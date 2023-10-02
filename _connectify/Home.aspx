
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="_connectify.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" type="text/css" href="Styles/PostStyle.css" />
    <link rel="stylesheet" type="text/css" href="Styles/style2.css" />
    <title>Connectify Home Page</title>

    <style>
    </style>
</head>
<body>
    <form id="formHome" runat="server">
        <div class="navbar">
         
            <asp:HyperLink ID="lnkMyPost1" runat="server" NavigateUrl="~/ViewMyPost.aspx" Text="My Post"></asp:HyperLink>
            <asp:HyperLink ID="lnkAddPost1" runat="server" NavigateUrl="~/NewPost.aspx" Text="Add New Post"></asp:HyperLink>
            <asp:HyperLink ID="lnkFolks1" runat="server" NavigateUrl="~/Folk.aspx" Text="Folks"></asp:HyperLink>
            <asp:Button ID="logout_button" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-button" />
            
        </div>

               <div class="post-container">
            <asp:Repeater ID="rptPosts1" runat="server" OnItemCommand="rptPosts_ItemCommand" OnItemDataBound="rptPosts_ItemDataBound">
                <ItemTemplate>
                    <div class="card">
                        <div class="card-header">
                            <h2>Title: <%# Eval("Title") %></h2>
                        </div>
                        <div class="card-body">
                            <asp:Image ID="imgPost1" Height="240" Width="220" runat="server" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("PostImage")) %>' />
                            <p>By : <%# Eval("UserName") %></p>
                            <p>Description: <%# Eval("Description") %></p>
                            <p>Date: <%# Eval("Date", "{0:MM/dd/yyyy}") %></p>
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnLike1" runat="server" Text="Like" CssClass='<%# ((bool)Eval("IsLiked")) ? "btn-like-liked" : "btn-like" %>' CommandName="Like" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnDislike1" runat="server" Text="Dislike" CssClass='<%#((bool)Eval("IsDisliked")) ? "btn-dislike-disliked": "btn-dislike" %>' CommandName="DisLike" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnLikedBy1" runat="server" Text="Liked By" CssClass="btn-like" CommandName="LikedBy" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnDislikedBy1" runat="server" Text="Disliked By" CssClass="btn-dislike" CommandName="DislikedBy" CommandArgument='<%# Eval("Id") %>' />
                            

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </form>
</body>
</html>




