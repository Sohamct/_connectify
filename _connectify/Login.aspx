<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_connectify.Login" ContentType="text/html" ResponseEncoding="utf-8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Styles/LoginStyle.css" />
    <title>Login Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Login</h1>
            <div>

                <label>Username: </label>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" ForeColor="#CC0000" runat="server" ControlToValidate="txtUserName" ValidationGroup="LoginGroup"
                    ErrorMessage="UserName is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label>Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" ForeColor="#CC0000" runat="server" ControlToValidate="txtPassword" ValidationGroup="LoginGroup"
                    ErrorMessage="Password is required"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div>
            <asp:Button type="submit" CssClass="login-button" ID="btnLogin" runat="server" ValidationGroup="LoginGroup" Text="Login" OnClick="btnLogin_Click" />
            <asp:Button CssClass="login-button" ID="btnSignup" runat="server" Text="Register" OnClick="btnSignup_Click" />
        </div>
        <div>
            
        </div>


    </form>
</body>
</html>
