Imports System.Data.SqlClient
Imports System.Configuration
Public Class u_profile
    Inherits System.Web.UI.Page
    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("SkrollDb").ConnectionString)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("user_id") Is Nothing Then
            Response.Redirect("login.aspx")
        End If

        For Each item1 As RepeaterItem In search_r1.Items
            Dim search_id As LinkButton = CType(item1.FindControl("search_id"), LinkButton)
            AddHandler search_id.Click, AddressOf search_id_Click
        Next

        For Each item2 As RepeaterItem In f1_r1.Items
            Dim f_info_holder1 As LinkButton = CType(item2.FindControl("f_info_holder1"), LinkButton)
            AddHandler f_info_holder1.Click, AddressOf f_info_holder1_Click
        Next

        For Each item3 As RepeaterItem In f2_r1.Items
            Dim f_info_holder2 As LinkButton = CType(item3.FindControl("f_info_holder2"), LinkButton)
            AddHandler f_info_holder2.Click, AddressOf f_info_holder2_Click
        Next

        For Each item4 As RepeaterItem In f1_r1.Items
            Dim f_remove1 As Button = CType(item4.FindControl("f_remove1"), Button)
            AddHandler f_remove1.Click, AddressOf f_remove1_Click
        Next

        For Each item5 As RepeaterItem In f2_r1.Items
            Dim f_remove2 As Button = CType(item5.FindControl("f_remove2"), Button)
            AddHandler f_remove2.Click, AddressOf f_remove2_Click
        Next

        For Each item6 As RepeaterItem In noti_r1.Items
            Dim noti_info_holder As LinkButton = CType(item6.FindControl("noti_info_holder"), LinkButton)
            AddHandler noti_info_holder.Click, AddressOf noti_info_holder_Click
        Next

        For Each item7 As RepeaterItem In p_r1.Items
            Dim p_img_holder As LinkButton = CType(item7.FindControl("p_img_holder"), LinkButton)
            AddHandler p_img_holder.Click, AddressOf p_img_holder_Click
        Next

        For Each item8 As RepeaterItem In p_r2.Items
            Dim p_vid_holder As LinkButton = CType(item8.FindControl("p_vid_holder"), LinkButton)
            AddHandler p_vid_holder.Click, AddressOf p_vid_holder_Click
        Next

        For Each item9 As RepeaterItem In cmt_r1.Items
            Dim o_cmt_user_info As LinkButton = CType(item9.FindControl("o_cmt_user_info"), LinkButton)
            AddHandler o_cmt_user_info.Click, AddressOf o_cmt_user_info_Click
        Next

        edit_b_date.Attributes("max") = DateTime.Now.ToString("yyyy-MM-dd")
        If Not IsPostBack Then
            load_user_img()
            user_information()
            social_network_count()
            social_network_display()
            notification()
            user_post_display()
        End If

    End Sub
    ' Post and Follower-Following Count
    Protected Sub social_network_count()

        
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))
        
        Dim f_s2 As String = "select count(*) from social_network where user_id=@user_id2"
        Dim f_s3 As String = "select count(*) from social_network where follower_id=@user_id3"
        Dim p_s1 As String = "select count(*) from post_master where user_id=@user_id4"
        Dim f_q2 As New SqlCommand(f_s2, con)
        Dim f_q3 As New SqlCommand(f_s3, con)
        Dim p_q1 As New SqlCommand(p_s1, con)
        f_q2.Parameters.AddWithValue("@user_id2", user_id)
        f_q3.Parameters.AddWithValue("@user_id3", user_id)
        p_q1.Parameters.AddWithValue("@user_id4", user_id)

        con.Open()
        Dim total_followers As String = Convert.ToString(f_q2.ExecuteScalar())
        Dim total_followings As String = Convert.ToString(f_q3.ExecuteScalar())
        Dim total_posts As String = Convert.ToString(p_q1.ExecuteScalar())
        con.Close()

        followers_count.Text = total_followers + " followers"
        following_count.Text = total_followings + " following"
        post_count.Text = total_posts + " posts"


    End Sub

    ' Social Network Display
    Protected Sub social_network_display()

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        ' Followers Display
        
        Dim u_s1 As String = "select u.user_id, u.user_nm, u.user_p, s.date, s.follower_id from user_info u, social_network s where u.user_id=s.follower_id and s.user_id=@user_id1 order by s.date desc"
        Dim u_q1 As New SqlCommand(u_s1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = u_q1.ExecuteReader()
        If reader1.HasRows Then
            Dim dt As New DataTable()
            dt.Load(reader1)
            f1_r1.DataSource = dt
            f1_r1.DataBind()
        End If
        con.Close()


        ' Following display
        
        Dim u_s2 As String = "select u.user_id, u.user_nm, u.user_p, s.date, s.user_id from user_info u, social_network s where u.user_id=s.user_id and s.follower_id=@user_id2 order by s.date desc"
        Dim u_q2 As New SqlCommand(u_s2, con)
        u_q2.Parameters.AddWithValue("@user_id2", user_id)

        con.Open()
        Dim reader2 As SqlDataReader = u_q2.ExecuteReader()
        If reader2.HasRows Then
            Dim dt As New DataTable()
            dt.Load(reader2)
            f2_r1.DataSource = dt
            f2_r1.DataBind()
        End If
        con.Close()

    End Sub

    ' Load Images 
    Protected Sub load_user_img()

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim is1 As String = "select user_p from user_info where user_id=@user_id1"
        Dim iq1 As New SqlCommand(is1, con)
        iq1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = iq1.ExecuteReader()
        If reader1.Read Then
            Dim user_img As String = Convert.ToString(reader1("user_p"))
            If user_img = "" Or user_img = "~/images/user.png" Then
                sidebar_p_img.ImageUrl = "~/images/user.png"
                user_img_holder.ImageUrl = "~/images/user.png"
                a_user_img.ImageUrl = "~/images/user.png"
                edit_img_holder.ImageUrl = "~/images/user.png"
                u_p_img.ImageUrl = "~/images/user.png"



                user_img_remove.Visible = False
            Else
                sidebar_p_img.ImageUrl = user_img
                user_img_holder.ImageUrl = user_img
                a_user_img.ImageUrl = user_img
                edit_img_holder.ImageUrl = user_img
                u_p_img.ImageUrl = user_img

                user_img_remove.Visible = True
            End If

        End If
        con.Close()

    End Sub

    ' User Information
    Protected Sub user_information()
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))
        Dim u_s1 As String = "select * from user_info where user_id=@user_id1"
        Dim u_q1 As New SqlCommand(u_s1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        Dim reader1 As SqlDataReader = u_q1.ExecuteReader()
        If reader1.Read Then
            Dim user_nm As String = Convert.ToString(reader1("user_nm"))
            Dim f_nm As String = Convert.ToString(reader1("f_name"))
            Dim l_nm As String = Convert.ToString(reader1("l_name"))
            Dim u_bio As String = Convert.ToString(reader1("user_bio"))
            Dim gender As String = Convert.ToString(reader1("gender"))
            Dim joined_datetime As DateTime = Convert.ToDateTime(reader1("date"))
            Dim joined_date As String = joined_datetime.ToString("dd MMM yyyy")

            If Not IsDBNull(reader1("b_date")) Then
                Dim b_datetime As DateTime = Convert.ToDateTime(reader1("b_date"))
                Dim b_date As String = b_datetime.ToString("yyyy-MM-dd")
                edit_b_date.Text = b_date
            Else
                edit_b_date.Text = ""
            End If
            If gender = "Male" Then
                rd_male.Checked = True
                gen_display.Text = "he"
            ElseIf gender = "Female" Then
                rd_female.Checked = True
                gen_display.Text = "she"
            Else
                rd_male.Checked = False
                rd_female.Checked = False
                gen_display.Text = ""
            End If

            user_name.Text = user_nm
            a_usernm.Text = user_nm
            u_p_nm.Text = user_nm
            full_name.Text = f_nm + " " + l_nm
            edit_f_name.Text = f_nm
            a_user_f_nm.Text = f_nm + " " + l_nm
            edit_l_name.Text = l_nm
            bio.Text = u_bio
            edit_bio.Text = u_bio
            a_u_joined_date.Text = "Joined on: " + joined_date



        End If
        con.Close()

    End Sub

    'User Post Display
    Protected Sub user_post_display()
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim p_s1 As String = "SELECT p.*, (SELECT COUNT(*) FROM comment_master WHERE post_id = p.p_id) AS cmt_count, (SELECT COUNT(*) FROM like_master WHERE post_id = p.p_id) AS like_count FROM post_master p WHERE p.user_id = @user_id1 AND p.p_category = 'I' ORDER BY p.p_date DESC"
        Dim p_s2 As String = "SELECT p.*, (SELECT COUNT(*) FROM comment_master WHERE post_id = p.p_id) AS cmt_count, (SELECT COUNT(*) FROM like_master WHERE post_id = p.p_id) AS like_count FROM post_master p WHERE p.user_id = @user_id2 AND p.p_category = 'V' ORDER BY p.p_date DESC"
        Dim p_q1 As New SqlCommand(p_s1, con)
        Dim p_q2 As New SqlCommand(p_s2, con)
        p_q1.Parameters.AddWithValue("@user_id1", user_id)
        p_q2.Parameters.AddWithValue("@user_id2", user_id)

        'Image Post Load
        con.Open()
        Dim reader1 As SqlDataReader = p_q1.ExecuteReader()
        If reader1.HasRows Then
            Dim dt1 As New DataTable()
            dt1.Load(reader1)
            p_r1.DataSource = dt1
            p_r1.DataBind()
        End If
        con.Close()

        'Video Post Load
        con.Open()
        Dim reader2 As SqlDataReader = p_q2.ExecuteReader()
        If reader2.HasRows Then
            Dim dt2 As New DataTable()
            dt2.Load(reader2)
            dt2.Columns.Add("html_vid", GetType(String))
            For Each row As DataRow In dt2.Rows
                Dim vid_path As String = row("p_img").ToString()
                Dim updated_path As String = "." + ResolveUrl(vid_path)
                row("html_vid") = "<video class='image_holder' muted autoplay>" &
                "<source src='" & updated_path & "' type='video/mp4'>" &
                "Your browser does not support video tag"
            Next

            p_r2.DataSource = dt2
            p_r2.DataBind()
        End If
        con.Close()

    End Sub

    ' Open User's Photo Post
    Protected Sub p_img_holder_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        post_panel.CssClass = "post_panel_opened"
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim p_img As Image = CType(item.FindControl("p_img"), Image)
        Dim p_id As Label = CType(item.FindControl("p_id1"), Label)

        Dim html_img_url As String = "." + ResolveUrl(p_img.ImageUrl)
        Dim html_img As String = "<img src='" & html_img_url & "' class='image_holder' alt='" & p_img.ImageUrl & "' />"

        post_literal.Text = html_img
        post_id.Text = p_id.Text

        ' Loading Description
        Dim p_s1 As String = "select u.user_nm,u.user_p,p.p_desc,p.p_location from user_info u, post_master p where u.user_id=p.user_id and p.user_id=@user_id1 and p.p_id=@post_id1"
        Dim p_q1 As New SqlCommand(p_s1, con)
        p_q1.Parameters.AddWithValue("@user_id1", user_id)
        p_q1.Parameters.AddWithValue("@post_id1", p_id.Text)

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

            edit_post_desc.Text = p_desc
            edit_post_loc.Text = p_loc
        Else
            post_desc.Visible = False
        End If
        con.Close()


        ' Loading Comments
        Dim c_s1 As String = "select u.user_id,u.user_nm,u.user_p,c.cmt from user_info u,comment_master c where u.user_id=c.user_id and c.post_id=@post_id2 order by c.date desc"
        Dim c_q1 As New SqlCommand(c_s1, con)
        c_q1.Parameters.AddWithValue("@post_id2", p_id.Text)

        con.Open()
        Dim ad1 As New SqlDataAdapter(c_q1)
        Dim dt1 As New DataTable()
        ad1.Fill(dt1)
        cmt_r1.DataSource = dt1
        cmt_r1.DataBind()
        con.Close()


    End Sub

    ' Open User's Video Post
    Protected Sub p_vid_holder_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        post_panel.CssClass = "post_panel_opened"
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim p_vid As Literal = CType(item.FindControl("p_vid"), Literal)
        Dim p_id As Label = CType(item.FindControl("p_id2"), Label)

        Dim html_vid_url As String = "." + ResolveUrl(p_vid.Text)
        Dim html_vid As String = "<video class='image_holder' muted autoplay>" &
                "<source src='" & html_vid_url & "' type='video/mp4'>" &
                "Your browser does not support video tag"

        post_literal.Text = html_vid
        post_id.Text = p_id.Text


        ' Loading Description
        Dim p_s1 As String = "select u.user_nm,u.user_p,p.p_desc,p.p_location from user_info u, post_master p where u.user_id=p.user_id and p.user_id=@user_id1 and p.p_id=@post_id1"
        Dim p_q1 As New SqlCommand(p_s1, con)
        p_q1.Parameters.AddWithValue("@user_id1", user_id)
        p_q1.Parameters.AddWithValue("@post_id1", p_id.Text)

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

            edit_post_desc.Text = p_desc
            edit_post_loc.Text = p_loc
        Else
            post_desc.Visible = False
        End If
        con.Close()


        ' Loading Comments
        Dim c_s1 As String = "select u.user_id,u.user_nm,u.user_p,c.cmt from user_info u,comment_master c where u.user_id=c.user_id and c.post_id=@post_id2 order by c.date desc"
        Dim c_q1 As New SqlCommand(c_s1, con)
        c_q1.Parameters.AddWithValue("@post_id2", p_id.Text)

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
            Response.Redirect("u_profile.aspx")
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

    ' Like Insert and Delete
    Protected Sub like_icon_Click(ByVal sender As Object, ByVal e As EventArgs) Handles like_icon.Click

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim like_status_value As String = like_status.Value

        If like_status_value = "filled" Then

            Dim l_i1 As String = "insert into like_master(user_id,post_id) values(@user_id1,@post_id1)"
            Dim l_q1 As New SqlCommand(l_i1, con)
            l_q1.Parameters.AddWithValue("@user_id1", user_id)
            l_q1.Parameters.AddWithValue("@post_id1", post_id.Text)

            con.Open()
            If l_q1.ExecuteNonQuery() Then
                Response.Redirect("u_profile.aspx")
            End If
            con.Close()
        End If

        If like_status_value = "outlined" Then
            Dim l_d1 As String = "delete from like_master where user_id=@user_id2 and post_id=@post_id2"
            Dim l_q2 As New SqlCommand(l_d1, con)
            l_q2.Parameters.AddWithValue("@user_id2", user_id)
            l_q2.Parameters.AddWithValue("@post_id2", post_id.Text)

            con.Open()
            If l_q2.ExecuteNonQuery() Then
                Response.Redirect("u_profile.aspx")
            End If
            con.Close()
        End If

    End Sub

    ' Save Post Changes
    Protected Sub post_save_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles post_save_btn.Click

        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim p_u1 As String = "update post_master set p_desc=@p_desc1, p_location=@p_loc1 where p_id=@post_id1"
        Dim p_q1 As New SqlCommand(p_u1, con)
        p_q1.Parameters.AddWithValue("@p_desc1", edit_post_desc.Text)
        p_q1.Parameters.AddWithValue("@p_loc1", edit_post_loc.Text)
        p_q1.Parameters.AddWithValue("@post_id1", post_id.Text)

        con.Open()
        If p_q1.ExecuteNonQuery() Then
            Response.Redirect("u_profile.aspx")
        End If
        con.Close()

    End Sub

    ' Delete Post
    Protected Sub post_del_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles post_del_btn.Click
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))

        Dim p_d1 As String = "delete from post_master where p_id=@post_id1"
        Dim p_q1 As New SqlCommand(p_d1, con)
        p_q1.Parameters.AddWithValue("@post_id1", post_id.Text)

        con.Open()
        If p_q1.ExecuteNonQuery() Then
            Response.Redirect("u_profile.aspx")
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

    ' Save Changes
    Protected Sub edit_save_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles edit_save_btn.Click
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))
        If edit_img_btn.HasFile Then
            Dim fe As String = System.IO.Path.GetExtension(edit_img_btn.FileName).ToLower()
            If fe = ".jpg" Or fe = ".jpeg" Then
                Dim file_nm As String = "~/images/" + edit_img_btn.FileName
                edit_img_btn.SaveAs(Server.MapPath(file_nm))

                Dim u_u2 As String = "UPDATE user_info SET user_p=@user_p1 where user_id=@user_id2"
                Dim u_q2 As New SqlCommand(u_u2, con)
                u_q2.Parameters.AddWithValue("@user_p1", file_nm)
                u_q2.Parameters.AddWithValue("@user_id2", user_id)

                con.Open()
                u_q2.ExecuteNonQuery()
                con.Close()
            End If
        End If



        Dim u_u1 As String = "UPDATE user_info SET f_name=@f_nm1, l_name=@l_nm1, user_bio=@bio1, gender=@gen1, b_date=@b_date1 where user_id=@user_id1"
        Dim u_q1 As New SqlCommand(u_u1, con)
        u_q1.Parameters.AddWithValue("@f_nm1", edit_f_name.Text)
        u_q1.Parameters.AddWithValue("@l_nm1", edit_l_name.Text)
        u_q1.Parameters.AddWithValue("@bio1", edit_bio.Text)
        u_q1.Parameters.AddWithValue("@b_date1", edit_b_date.Text)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)
        If rd_male.Checked = True Then
            u_q1.Parameters.AddWithValue("@gen1", "Male")
        ElseIf rd_female.Checked = True Then
            u_q1.Parameters.AddWithValue("@gen1", "Female")
        Else
            u_q1.Parameters.AddWithValue("@gen1", "")
        End If
        con.Open()
        u_q1.ExecuteNonQuery()
        Response.Redirect("u_profile.aspx")
        con.Close()

    End Sub

    ' Remove User Profile Image
    Protected Sub user_img_remove_Click(ByVal sender As Object, ByVal e As EventArgs) Handles user_img_remove.Click
        Dim user_id As Integer = Convert.ToInt32(Session("user_id"))
        Dim default_user_img As String = "~/images/user.png"
        Dim u_u1 As String = "UPDATE user_info SET user_p=@user_p1 where user_id=@user_id1"
        Dim u_q1 As New SqlCommand(u_u1, con)
        u_q1.Parameters.AddWithValue("@user_p1", default_user_img)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        u_q1.ExecuteNonQuery()

        con.Close()
    End Sub

    ' Redirect to other user profile
    Protected Sub f_info_holder1_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim f_user_id As Label = CType(item.FindControl("f_user_id1"), Label)
        Dim user_id As String = f_user_id.Text
        Session("f_user_id") = user_id
        Response.Redirect("f_profile.aspx")
    End Sub

    ' Redirect to other user profile
    Protected Sub f_info_holder2_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim button As LinkButton = CType(sender, LinkButton)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim f_user_id As Label = CType(item.FindControl("f_user_id2"), Label)
        Dim user_id As String = f_user_id.Text
        Session("f_user_id") = user_id
        Response.Redirect("f_profile.aspx")
    End Sub

    ' Remove Follower
    Protected Sub f_remove1_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim button As Button = CType(sender, Button)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim f_user_id As Label = CType(item.FindControl("f_user_id1"), Label)
        Dim user_id As String = f_user_id.Text

        Dim u_d1 As String = "delete social_network where follower_id=@user_id1"
        Dim u_q1 As New SqlCommand(u_d1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        u_q1.ExecuteNonQuery()
        Response.Redirect("u_profile.aspx")
        con.Close()

    End Sub

    ' Remove Following
    Protected Sub f_remove2_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim button As Button = CType(sender, Button)
        Dim item As RepeaterItem = CType(button.NamingContainer, RepeaterItem)
        Dim f_user_id As Label = CType(item.FindControl("f_user_id2"), Label)
        Dim user_id As String = f_user_id.Text

        Dim u_d1 As String = "delete social_network where user_id=@user_id1"
        Dim u_q1 As New SqlCommand(u_d1, con)
        u_q1.Parameters.AddWithValue("@user_id1", user_id)

        con.Open()
        u_q1.ExecuteNonQuery()
        Response.Redirect("u_profile.aspx")
        con.Close()
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