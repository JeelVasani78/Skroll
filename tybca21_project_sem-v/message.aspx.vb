Imports System.Data.SqlClient
Imports System.Configuration
Public Class message
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


        load_user_img()
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

End Class