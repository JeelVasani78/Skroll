Imports System.Data.SqlClient
Imports System.Configuration
Public Class login
    Inherits System.Web.UI.Page
    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("SkrollDb").ConnectionString)
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Protected Sub login_btn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles login_btn.Click
        If String.IsNullOrWhiteSpace(email.Text) Or
            String.IsNullOrWhiteSpace(pass.Text) Then

            error_msg.Text = "Please Fill all the Fields!"
            error_msg.Visible = True

        Else

            Dim s_s1 = "select * from user_info where email=@email"
            Dim s_q1 As New SqlCommand(s_s1, con)
            s_q1.Parameters.AddWithValue("@email", email.Text)

            con.Open()
            Dim reader1 As SqlDataReader = s_q1.ExecuteReader()

            If reader1.Read() Then
                Dim user_id As Integer = Convert.ToInt32(reader1("user_id"))
                Dim password As String = Convert.ToString(reader1("password"))
                If password = pass.Text Then
                    Session("user_id") = user_id
                    Response.Redirect("user_dashboard.aspx")
                    con.Close()
                Else
                    error_msg.Text = "Wrong password!"
                    error_msg.Visible = True
                End If
            Else

                error_msg.Text = "Account does not exists. Please Create!"
                error_msg.Visible = True

            End If

        End If
    End Sub
End Class
