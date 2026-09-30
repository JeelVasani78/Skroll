<!-- 13-07-2024 -->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="signup.aspx.vb" Inherits="tybca21_project_sem_v.signup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp | Skroll</title>
    <link rel="stylesheet" href="signup.css"/> 
    <link rel="shortcut icon" type="x-icon" href="./images/nav_logo3.png" />
</head>
<body>
    <div class="main">
        <div class="left">
            <h1>SignUp</h1>
            <form id="frm1" runat="server">
                <div class="left_top">
                    <asp:TextBox ID="f_name" runat="server" CssClass="txt1" TextMode="SingleLine" placeholder="First Name" MaxLength="20"></asp:TextBox>
                    <asp:TextBox ID="l_name" runat="server" CssClass="txt1"  TextMode="SingleLine" placeholder="Last Name" MaxLength="20"></asp:TextBox>
                </div>
                <div class="left_bottom">
                    <asp:TextBox ID="user_nm" runat="server" CssClass="txt2" TextMode="SingleLine" placeholder="Username" MaxLength="20"></asp:TextBox>
                    <asp:TextBox ID="email" runat="server" CssClass="txt2" TextMode="SingleLine" placeholder="Email"></asp:TextBox>
                    <asp:TextBox ID="pass" runat="server" CssClass="txt2"  TextMode="Password" placeholder="Password" MaxLength="15"></asp:TextBox>
                    <asp:TextBox ID="c_pass" runat="server" CssClass="txt2" TextMode="Password" placeholder="Confirm Password" MaxLength="15"></asp:TextBox>
                    <asp:Button ID="signup_btn" runat="server" CssClass="btn1" Text="SignUp" />
                    <asp:HyperLink ID="login_page" cssClass="login_page" runat="server" NavigateUrl="login.aspx">Already have an account? Login</asp:HyperLink>
                </div>
            </form>
            <asp:Label ID="error_msg" runat="server" Text="error_lbl" Visible="false" ForeColor="red"></asp:Label>
        </div>
        <div class="right">
            <div class="logo_holder"></div>
        </div>
    </div>
</body>
</html>
