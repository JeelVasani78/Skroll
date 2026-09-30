<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="login.aspx.vb" Inherits="tybca21_project_sem_v.login" EnableSessionState="True"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LogIn | Skroll</title>
    <link rel="stylesheet" href="signup.css"/> 
    <link rel="shortcut icon" type="x-icon" href="./images/nav_logo3.png"/>
</head>
<body>
   <div class="main">
        <div class="left">
            <h1>LogIn</h1>
            <form id="frm1" runat="server">
                <div class="left_bottom">
                    <asp:TextBox ID="email" runat="server" CssClass="txt2" TextMode="SingleLine" placeholder="Email"></asp:TextBox>
                    <asp:TextBox ID="pass" runat="server" CssClass="txt2"  TextMode="Password" placeholder="Password" MaxLength="15"></asp:TextBox>
                    <asp:HyperLink ID="forgot_pass" runat="server" CssClass="forgot_pass" NavigateUrl="forgot.aspx">Forgot Password?</asp:HyperLink>
                    <asp:Button ID="login_btn" runat="server" CssClass="btn1" Text="LogIn" />
                    <asp:HyperLink ID="login_page" cssClass="login_page" runat="server" NavigateUrl="signup.aspx">Don't have an account? Create</asp:HyperLink>
                </div>
            </form>
            <asp:Label ID="error_msg" runat="server" Visible="false" ForeColor="red"></asp:Label>
        </div>
        <div class="right">
            <div class="logo_holder"></div>
        </div>
    </div>
</body>
</html>
