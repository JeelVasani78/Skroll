Imports System.Data.SqlClient
Imports System.Configuration
Public Class forgot
    Inherits System.Web.UI.Page
    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("SkrollDb").ConnectionString)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub reset_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles reset_btn.Click
        If String.IsNullOrWhiteSpace(email.Text) Or
            String.IsNullOrWhiteSpace(pass.Text) Or
            String.IsNullOrWhiteSpace(c_pass.Text) Then

            error_msg.Text = "Please Fill all the Fields!"
            error_msg.Visible = True

        Else

            Dim s_s1 = "select count(*) from user_info where email=@email"
            Dim s_q1 As New SqlCommand(s_s1, con)
            s_q1.Parameters.AddWithValue("@email", email.Text)

            con.Open()
            Dim email_count As Integer = Convert.ToInt32(s_q1.ExecuteScalar())
            con.Close()

            If email_count <> 0 Then

                If pass.Text = c_pass.Text Then
                    Dim s_s2 = "update user_info set password=@pass where email=@email1"
                    Dim s_q2 As New SqlCommand(s_s2, con)
                    s_q2.Parameters.AddWithValue("@email1", email.Text)
                    s_q2.Parameters.AddWithValue("@pass", pass.Text)

                    con.Open()
                    If s_q2.ExecuteNonQuery() Then
                        Response.Redirect("login.aspx")
                    End If
                    con.Close()

                Else
                    error_msg.Text = "Passwords do not match!"
                    error_msg.Visible = True
                End If

            Else

                error_msg.Text = "Account does not exists. Please Create!"
                error_msg.Visible = True

            End If

        End If
    End Sub
End Class
