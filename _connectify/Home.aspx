<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="_connectify.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Web Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding-top: 60px; /* Adjust for fixed navbar */
        }

        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #333;
            padding: 10px;
            text-align: center;
        }

        .navbar a {
            color: white;
            padding: 14px 16px;
            text-decoration: none;
            display: inline-block;
            margin: 0 10px;
        }

        .content {
            margin: 20px;
        }

        h1, h2 {
            text-align: center;
        }
        .logout-button {
    background-color: #fff;
    color: #333;
    border: 1px solid #ccc;
    padding: 8px 16px;
    font-size: 14px;
    cursor: pointer;
    margin-left: 10px;
}

.logout-button:hover {
    background-color: #ccc;
}
    </style>
</head>
<body>
    <form runat="server">
        <div class="navbar">
            <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Home.aspx" Text="Home"></asp:HyperLink>
            <asp:HyperLink ID="lnkMyPost" runat="server" NavigateUrl="~/MyPost.aspx" Text="My Post"></asp:HyperLink>
            <asp:HyperLink ID="lnkAddPost" runat="server" NavigateUrl="~/AddPost.aspx" Text="Add Post"></asp:HyperLink>
            <asp:HyperLink ID="lnkFolks" runat="server" NavigateUrl="~/Folk.aspx" Text="Folks"></asp:HyperLink>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-button" />
            
        </div>

        <div class="content">
            <!-- Your content goes here -->
        </div>
    </form>
</body>
</html>




