<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPost.aspx.cs" Inherits="_connectify.NewPost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"> 
    <link rel="stylesheet" type="text/css" href="Styles/style1.css"/>
    <link rel="stylesheet" type="text/css" href="Styles/style2.css"/>
    <title>New Post</title>
</head>
<body>
    <form  runat="server">
    <div class="navbar">
        <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Home.aspx" Text="Home"></asp:HyperLink>
        <asp:HyperLink ID="lnkMyPost" runat="server" NavigateUrl="~/ViewMyPost.aspx" Text="My Post"></asp:HyperLink>
        <asp:HyperLink ID="lnkFolks" runat="server" NavigateUrl="~/Folk.aspx" Text="Folks"></asp:HyperLink>
        <asp:Button ID="logout_button" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout_button" />
    </div>

        <div id="postForm">
            <div>
                <label for="txtTitle">Title:</label>
                <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTitle" ForeColor="#CC0000" runat="server" ControlToValidate="txtTitle"
                    ErrorMessage="Post Title is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label for="txtDescription">Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescription" ForeColor="#CC0000" runat="server" ControlToValidate="txtDescription"
                    ErrorMessage="Post description is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label for="fileImage">Post Image:</label>
                <asp:FileUpload ID="fileImage" runat="server" />
                <asp:RequiredFieldValidator ID="rfvFileImage" ForeColor="#CC0000" runat="server" ControlToValidate="fileImage"
                    ErrorMessage="Post Image is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <asp:Button ID="btnSubmit" runat="server" CssClass="submitBtn" Text="Submit" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>

</body>
</html>
