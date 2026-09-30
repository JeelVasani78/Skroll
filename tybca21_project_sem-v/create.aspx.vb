Imports System.Data.SqlClient
Imports System.Configuration
Public Class create
    Inherits System.Web.UI.Page
    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("SkrollDb").ConnectionString)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("user_id") Is Nothing Then
            Response.Redirect("login.aspx")
        End If

        For Each item As RepeaterItem In search_r1.Items
            Dim search_id As LinkButton = CType(item.FindControl("search_id"), LinkButton)
            AddHandler search_id.Click, AddressOf search_id_Click
        Next

        For Each item6 As RepeaterItem In noti_r1.Items
            Dim noti_info_holder As LinkButton = CType(item6.FindControl("noti_info_holder"), LinkButton)
            AddHandler noti_info_holder.Click, AddressOf noti_info_holder_Click
        Next


        If Not IsPostBack Then
            load_user_img()
            notification()
        End If
    End Sub

    ' Sidebar User Profile 
    Protected Sub load_user_img()

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim is1 As String = "select user_p from user_info where user_id=@user_id1"
        Dim iq1 As New SqlCommand(is1, con)
        iq1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = iq1.ExecuteReader()
        If reader1.Read Then
            Dim user_img As String = Convert.ToString(reader1("user_p"))
            If user_img = "" Then
                sidebar_p_img.ImageUrl = "~/images/user.png"
            Else
                sidebar_p_img.ImageUrl = user_img
            End If

        End If
        con.Close()

    End Sub

    ' Post Preview
    Protected Sub s_post_hidden_Click(ByVal sender As Object, ByVal e As EventArgs) Handles s_post_hidden.Click

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        If Not s_post.HasFile Then
            Return
        End If

        Dim f_nm As String = System.IO.Path.GetFileName(s_post.FileName)
        Dim fe As String = System.IO.Path.GetExtension(f_nm).ToLower()
        If fe <> ".jpg" AndAlso fe <> ".jpeg" AndAlso fe <> ".png" AndAlso fe <> ".mp4" Then
            Return
        End If

        post_creater1.CssClass = "post_creater_opened"
        Dim fp As String = System.IO.Path.Combine(Server.MapPath("~/images/"), f_nm)
        s_post.SaveAs(fp)
        s_file_nm_hidden.Text = "~/images/" + f_nm

        Dim u_s1 As String = "select user_p,user_nm from user_info where user_id=@user_id1"
        Dim u_q1 As New SqlCommand(u_s1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = u_q1.ExecuteReader()
        If reader1.Read() Then
            p_u_img.ImageUrl = Convert.ToString(reader1("user_p"))
            p_unm.Text = Convert.ToString(reader1("user_nm"))
        End If
        con.Close()

        s_file_extension_hidden.Text = fe

        If fe = ".jpg" Or fe = ".jpeg" Or fe = ".png" Then
            Dim img_url As String = "./images/" & s_post.FileName
            Dim html_img As String = "<img src='" & img_url & "' class='image_holder' alt='" & img_url & "' />"

            s_img.Text = html_img
        End If

        If fe = ".mp4" Then
            Dim vid_url As String = "./images/" & f_nm
            Dim html_vid As String = "<video class='image_holder' controls loop autoplay muted>" &
                                        "<source src='" & vid_url & "' type='video/mp4'>" &
                                        "Your browser does not support video tag!"
            s_img.Text = html_vid
        End If

    End Sub

    ' File Upload and Post Creation
    Protected Sub p_submit_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles p_submit_btn.Click
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim fe As String = s_file_extension_hidden.Text

        Dim curr_date As Date = Date.Now
        Dim f_i1 As String = "insert into post_master values(@user_id1,@p_img1,@p_desc1,@p_location1,@p_date1,@p_cat1)"
        Dim f_q1 As New SqlCommand(f_i1, con)
        f_q1.Parameters.AddWithValue("@user_id1", user_id)
        f_q1.Parameters.AddWithValue("@p_img1", s_file_nm_hidden.Text)
        f_q1.Parameters.AddWithValue("@p_desc1", post_desc.Text)
        f_q1.Parameters.AddWithValue("@p_location1", post_loc.Text)
        f_q1.Parameters.AddWithValue("@p_date1", curr_date)
        If fe = ".jpg" Or fe = ".jpeg" Or fe = ".png" Then
            f_q1.Parameters.AddWithValue("@p_cat1", "I")
        Else
            f_q1.Parameters.AddWithValue("@p_cat1", "V")
        End If

        con.Open()
        If f_q1.ExecuteNonQuery() Then
            Response.Redirect("user_dashboard.aspx")
        End If
        con.Close()

    End Sub

    ' Searchbar 
    Protected Sub search_input_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles search_input.TextChanged

        If String.IsNullOrWhiteSpace(search_input.Text) Then

            search_bar.CssClass = "empty_txt"

        Else

            search_bar.CssClass = "search_bar"
            Dim user_id As Integer = Convert.ToInt32(Session("user_id"))
            Dim input_usernm As String = search_input.Text
            Dim splited_nm() As String = search_input.Text.Split(" "c)
            Dim f_nm As String = splited_nm(0).Trim
            Dim l_nm As String = ""

            If splited_nm.Length > 1 Then
                l_nm = splited_nm(1).Trim
            End If
            Dim s_s1 As String = "select user_id,user_nm,user_p from user_info where user_nm LIKE @input_usernm or f_name LIKE @f_nm ORDER BY user_nm ASC"

            If Not String.IsNullOrEmpty(l_nm) Then
                s_s1 &= " and l_name LIKE @l_nm"
            End If

            Dim s_q1 As New SqlCommand(s_s1, con)
            s_q1.Parameters.AddWithValue("@input_usernm", input_usernm + "%")
            s_q1.Parameters.AddWithValue("@f_nm", f_nm + "%")
            If Not String.IsNullOrEmpty(l_nm) Then
                s_q1.Parameters.AddWithValue("@l_nm", l_nm + "%")
            End If
            con.Open()
            Dim reader1 As SqlDataReader = s_q1.ExecuteReader()

            If reader1.HasRows Then

                Dim dt As New DataTable()
                dt.Load(reader1)
                search_r1.DataSource = dt
                search_r1.DataBind()

                search_result.Visible = True

            Else

                search_result.Visible = False

            End If

            con.Close()
        End If

    End Sub

    ' Notification
    Protected Sub notification()
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim u_s1 As String = "select u.user_id, u.user_nm, u.user_p, s.date, s.follower_id from user_info u, social_network s where u.user_id=s.follower_id and s.user_id=@user_id1 order by s.date desc"
        Dim u_q1 As New SqlCommand(u_s1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = u_q1.ExecuteReader()
        If reader1.HasRows Then
            Dim dt As New DataTable()
            dt.Load(reader1)
            noti_r1.DataSource = dt
            noti_r1.DataBind()

            Dim curr_noti As Integer = dt.Rows.Count

            Dim stored_noti As Integer = 0
            If Request.Cookies("noti_count") IsNot Nothing Then
                Integer.TryParse(Request.Cookies("noti_count").Value, stored_noti)
            End If

            If curr_noti > stored_noti Then
                red_dot.CssClass = "red_dot_visible"
            Else
                red_dot.CssClass = "red_dot_hidden"
            End If

            Dim noti_count As New HttpCookie("noti_count", curr_noti.ToString())
            noti_count.Expires = DateTime.Now.AddDays(30)
            Response.Cookies.Add(noti_count)

        End If
        con.Close()
    End Sub
    'Logout
    Protected Sub logout_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles logout_btn.Click
        Session.Abandon()
        Session.Clear()
        Response.Redirect("login.aspx")
    End Sub


    ' Searched User Redirection
    Protected Sub search_id_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim s_f_user_id As Label = CType(item.FindControl("s_f_user_id"), Label)
        Dim userIdValue As String = s_f_user_id.Text
        Session("f_user_id") = userIdValue
        Response.Redirect("f_profile.aspx")
    End Sub

    ' Redirecting notification user
    Protected Sub noti_info_holder_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim noti_uid As Label = CType(item.FindControl("noti_uid"), Label)

        Dim user_id As String = noti_uid.Text
        Session("f_user_id") = user_id
        Response.Redirect("f_profile.aspx")
    End Sub
End Class