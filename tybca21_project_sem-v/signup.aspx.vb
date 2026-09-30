Imports System.Data.SqlClient
Imports System.Configuration
Public Class signup
    Inherits System.Web.UI.Page
    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("SkrollDb").ConnectionString)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub signup_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles signup_btn.Click

        If String.IsNullOrWhiteSpace(f_name.Text) Or
            String.IsNullOrWhiteSpace(l_name.Text) Or
            String.IsNullOrWhiteSpace(user_nm.Text) Or
            String.IsNullOrWhiteSpace(email.Text) Or
            String.IsNullOrWhiteSpace(pass.Text) Or
            String.IsNullOrWhiteSpace(c_pass.Text) Then

            error_msg.Text = "Please Fill all the Fields!"
            error_msg.Visible = True

        Else

            If pass.Text = c_pass.Text Then

                Dim s_s1 = "select count(*) from user_info where email=@email"
                Dim s_s2 = "select count(*) from user_info where user_nm=@user_nm"
                Dim s_q1 As New SqlCommand(s_s1, con)
                Dim s_q3 As New SqlCommand(s_s2, con)
                s_q1.Parameters.AddWithValue("@email", email.Text)
                s_q3.Parameters.AddWithValue("@user_nm", user_nm.Text)

                con.Open()
                Dim email_count As Integer = Convert.ToInt32(s_q1.ExecuteScalar())
                Dim user_count As Integer = Convert.ToInt32(s_q3.ExecuteScalar())
                con.Close()

                If email_count = 0 Then
                    If user_count = 0 Then

                        Dim c_date As Date = Date.Now
                        Dim default_img As String = "~/images/user.png"
                        Dim s_i1 As String = "insert into user_info(user_nm,f_name,l_name,email,password,date,user_p) values(@user_nm1,@f_name, @l_name, @email1, @password, @date, @u_p_img)"
                        Dim s_q2 As New SqlCommand(s_i1, con)
                        s_q2.Parameters.AddWithValue("@user_nm1", user_nm.Text)
                        s_q2.Parameters.AddWithValue("@f_name", f_name.Text)
                        s_q2.Parameters.AddWithValue("@l_name", l_name.Text)
                        s_q2.Parameters.AddWithValue("@email1", email.Text)
                        s_q2.Parameters.AddWithValue("@password", pass.Text)
                        s_q2.Parameters.AddWithValue("@date", c_date)
                        s_q2.Parameters.AddWithValue("@u_p_img", default_img)

                        con.Open()
                        If s_q2.ExecuteNonQuery() Then
                            Response.Redirect("login.aspx")
                        End If
                        con.Close()
                    Else
                        error_msg.Text = "Username is already taken!"
                        error_msg.Visible = True
                    End If
                Else

                    error_msg.Text = "Account already created. Please Login!"
                    error_msg.Visible = True

                End If

            Else

                error_msg.Text = "Passwords do not match!"
                error_msg.Visible = True

            End If

        End If
    End Sub
End Class
