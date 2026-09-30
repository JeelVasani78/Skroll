Imports System.Data.SqlClient
Imports System.Configuration
Public Class user_dashboard
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

        For Each item7 As RepeaterItem In dash_post_r1.Items
            Dim d_p_usernm As LinkButton = CType(item7.FindControl("d_p_usernm"), LinkButton)
            AddHandler d_p_usernm.Click, AddressOf d_p_usernm_Click
        Next

        For Each item8 As RepeaterItem In dash_post_r1.Items
            Dim comment_icon1 As LinkButton = CType(item8.FindControl("comment_icon1"), LinkButton)
            AddHandler comment_icon1.Click, AddressOf comment_icon1_Click
        Next

        For Each item9 As RepeaterItem In dash_post_r1.Items
            Dim cmt_post_btn1 As Button = CType(item9.FindControl("cmt_post_btn1"), Button)
            AddHandler cmt_post_btn1.Click, AddressOf cmt_post_btn1_Click
        Next

        If Not IsPostBack Then
            load_user_img()
            notification()
            load_top_users()
            load_posts()
        End If
    End Sub

    ' Load User Profile 
    Protected Sub load_user_img()

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim is1 As String = "select user_p,user_nm,f_name,l_name from user_info where user_id=@user_id1"
        Dim iq1 As New SqlCommand(is1, con)
        iq1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = iq1.ExecuteReader()
        If reader1.Read Then
            Dim user_img As String = Convert.ToString(reader1("user_p"))
            Dim user_nm As String = Convert.ToString(reader1("user_nm"))
            Dim f_nm As String = Convert.ToString(reader1("f_name"))
            Dim l_nm As String = Convert.ToString(reader1("l_name"))

            If user_img = "" Then
                sidebar_p_img.ImageUrl = "~/images/user.png"
                dash_user_img.ImageUrl = "~/images/user.png"

            Else
                sidebar_p_img.ImageUrl = user_img
                dash_user_img.ImageUrl = user_img

            End If

            dash_usernm.Text = user_nm
            dash_full_usernm.Text = f_nm + " " + l_nm

        End If
        con.Close()

    End Sub

    ' Load Top Users
    Protected Sub load_top_users()

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim u_s1 As String = "select u.user_id, u.user_nm, u.user_p,s.date from user_info u, social_network s where u.user_id=s.user_id and s.follower_id=@user_id1 order by s.date desc "
        Dim u_q1 As New SqlCommand(u_s1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = u_q1.ExecuteReader()
        If reader1.HasRows Then
            Dim dt1 As New DataTable()
            dt1.Load(reader1)
            dash_top_r1.DataSource = dt1
            dash_top_r1.DataBind()
        End If
        con.Close()

    End Sub

    ' Load Posts
    Protected Sub load_posts()

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim p_s1 As String = "select distinct u.user_id, u.user_nm, u.user_p, p.p_id, p.p_img, p.p_location, p.p_date from user_info u, post_master p, social_network s where u.user_id=p.user_id and u.user_id=s.user_id and s.follower_id=@user_id1 and p.p_category='I' order by p.p_date desc"
        Dim p_q1 As New SqlCommand(p_s1, con)
        p_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = p_q1.ExecuteReader()
        If reader1.HasRows Then
            Dim dt1 As New DataTable()
            dt1.Load(reader1)
            dash_post_r1.DataSource = dt1
            dash_post_r1.DataBind()
        End If
        con.Close()

    End Sub

    ' Post User Redirection
    Protected Sub d_p_usernm_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim u_id As HiddenField = CType(item.FindControl("d_p_hidden_uid"), HiddenField)

        Session("f_user_id") = u_id.Value
        Response.Redirect("f_profile.aspx")
    End Sub

    ' Open User Post
    Protected Sub comment_icon1_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        post_panel.CssClass = "post_panel_opened"
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim u_id As HiddenField = CType(item.FindControl("d_p_hidden_uid"), HiddenField)
        Dim p_img As Image = CType(item.FindControl("d_post_img"), Image)
        Dim p_id As HiddenField = CType(item.FindControl("d_p_hidden_pid"), HiddenField)

        Dim html_img_url As String = "." + ResolveUrl(p_img.ImageUrl)
        Dim html_img As String = "<img src='" & html_img_url & "' class='image_holder' alt='" & p_img.ImageUrl & "' />"

        post_literal.Text = html_img
        post_id.Text = p_id.Value

        ' Loading Description
        Dim p_s1 As String = "select u.user_nm,u.user_p,p.p_desc,p.p_location from user_info u, post_master p where u.user_id=p.user_id and p.user_id=@user_id1 and p.p_id=@post_id1"
        Dim p_q1 As New SqlCommand(p_s1, con)
        p_q1.Parameters.AddWithValue("@user_id1", u_id.Value)
        p_q1.Parameters.AddWithValue("@post_id1", p_id.Value)

        con.Open()
        Dim reader1 As SqlDataReader = p_q1.ExecuteReader()
        If reader1.Read Then
            Dim user_nm As String = Convert.ToString(reader1("user_nm"))
            Dim user_p As String = Convert.ToString(reader1("user_p"))
            Dim p_desc As String = Convert.ToString(reader1("p_desc"))
            Dim p_loc As String = Convert.ToString(reader1("p_location"))

            If p_desc = "" Or p_desc = "NULL" Then
                post_desc.Visible = False
            Else
                post_desc.Visible = True
                cmt_user_img.ImageUrl = user_p
                cmt_user_nm.Text = user_nm
                user_cmt.Text = p_desc
            End If

            u_p_img.ImageUrl = user_p
            u_p_nm.Text = user_nm
        Else
            post_desc.Visible = False
        End If
        con.Close()


        ' Loading Comments
        Dim c_s1 As String = "select u.user_id,u.user_nm,u.user_p,c.cmt from user_info u,comment_master c where u.user_id=c.user_id and c.post_id=@post_id2 order by c.date desc"
        Dim c_q1 As New SqlCommand(c_s1, con)
        c_q1.Parameters.AddWithValue("@post_id2", p_id.Value)

        con.Open()
        Dim ad1 As New SqlDataAdapter(c_q1)
        Dim dt1 As New DataTable()
        ad1.Fill(dt1)
        cmt_r1.DataSource = dt1
        cmt_r1.DataBind()
        con.Close()

    End Sub

    ' Comment Post Button
    Protected Sub cmt_post_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmt_post_btn.Click

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim p_i1 As String = "insert into comment_master(user_id,post_id,cmt) values(@user_id1,@post_id1,@cmt1)"
        Dim p_q1 As New SqlCommand(p_i1, con)
        p_q1.Parameters.AddWithValue("@user_id1", user_id)
        p_q1.Parameters.AddWithValue("@post_id1", Convert.ToInt32(post_id.Text))
        p_q1.Parameters.AddWithValue("@cmt1", cmt_txtbox.Text)

        con.Open()
        If p_q1.ExecuteNonQuery() Then
            Response.Redirect("user_dashboard.aspx")
        End If
        con.Close()

    End Sub

    ' Comment on User Post from Outside
    Protected Sub cmt_post_btn1_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim button As Button = CType(sender, Button)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim u_id As HiddenField = CType(item.FindControl("d_p_hidden_uid"), HiddenField)
        Dim p_id As HiddenField = CType(item.FindControl("d_p_hidden_pid"), HiddenField)
        Dim cmt_txtbox1 As TextBox = CType(item.FindControl("cmt_txtbox1"), TextBox)


        Dim p_i1 As String = "insert into comment_master(user_id,post_id,cmt) values(@user_id1,@post_id1,@cmt1)"
        Dim p_q1 As New SqlCommand(p_i1, con)
        p_q1.Parameters.AddWithValue("@user_id1", user_id)
        p_q1.Parameters.AddWithValue("@post_id1", Convert.ToInt32(p_id.Value))
        p_q1.Parameters.AddWithValue("@cmt1", cmt_txtbox1.Text)

        con.Open()
        If p_q1.ExecuteNonQuery() Then
            Response.Redirect("user_dashboard.aspx")
        End If
        con.Close()


    End Sub

    ' Comment User Redirection 
    Protected Sub cmt_user_info_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmt_user_info.Click
        Response.Redirect("u_profile.aspx")
    End Sub

    ' Comment User Redirection
    Protected Sub o_cmt_user_info_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim u_id As Label = CType(item.FindControl("o_cmt_user_id"), Label)

        Session("f_user_id") = u_id.Text
        Response.Redirect("f_profile.aspx")
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
            If Not String.IsNullOrEmpty(l_nm) Then
                Dim s_s1 As String = "select user_id,user_nm,user_p from user_info where user_nm LIKE @input_usernm or f_name LIKE @f_nm and l_name LIKE @l_nm ORDER BY user_nm"
                Dim s_q1 As New SqlCommand(s_s1, con)
                s_q1.Parameters.AddWithValue("@input_usernm", input_usernm + "%")
                s_q1.Parameters.AddWithValue("@f_nm", f_nm + "%")
                s_q1.Parameters.AddWithValue("@l_nm", l_nm + "%")

                con.Open()
                Dim reader1 As SqlDataReader = s_q1.ExecuteReader()

                If reader1.HasRows Then

                    Dim dt As New DataTable()
                    dt.Load(reader1)
                    search_r1.DataSource = dt
                    search_r1.DataBind()

                    search_result.Visible = True

                End If

                con.Close()
            Else
                Dim s_s1 As String = "select user_id,user_nm,user_p from user_info where user_nm LIKE @input_usernm or f_name LIKE @f_nm ORDER BY user_nm"
                Dim s_q1 As New SqlCommand(s_s1, con)
                s_q1.Parameters.AddWithValue("@input_usernm", input_usernm + "%")
                s_q1.Parameters.AddWithValue("@f_nm", f_nm + "%")

                con.Open()
                Dim reader1 As SqlDataReader = s_q1.ExecuteReader()

                If reader1.HasRows Then

                    Dim dt As New DataTable()
                    dt.Load(reader1)
                    search_r1.DataSource = dt
                    search_r1.DataBind()

                    search_result.Visible = True

                End If
                con.Close()
            End If
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

            'If Session("curr_noti") Is Nothing Then
            'Session("curr_noti") = curr_noti
            'Else
            'Dim stored_noti As Integer = Convert.ToInt32(Session("curr_noti"))

            'If curr_noti > stored_noti Then
            'red_dot.CssClass = "red_dot_visible"
            'Else
            'red_dot.CssClass = "red_dot_hidden"
            'End If
            'End If



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