﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="_connectify.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Login</h1>
            <div>
                

                <label>Username: </label>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" ForeColor="#CC0000" runat="server" ControlToValidate="txtUserName"
    ErrorMessage="UserName is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label>Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" ForeColor="#CC0000" runat="server" ControlToValidate="txtPassword"
ErrorMessage="Password is required"></asp:RequiredFieldValidator>
        </div>
            </div>
            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </div>
        
    </form>
</body>
</html>