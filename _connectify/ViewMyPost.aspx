<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMyPost.aspx.cs" Inherits="_connectify.ViewMyPost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <link rel="stylesheet" type="text/css" href="Styles/PostStyle.css" />
    <link rel="stylesheet" type="text/css" href="Styles/style2.css" />

    <title>Posts</title>
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">
            <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Home.aspx" Text="Home"></asp:HyperLink>
            <asp:HyperLink ID="lnkAddPost" runat="server" NavigateUrl="~/NewPost.aspx" Text="Add New Post"></asp:HyperLink>
            <asp:HyperLink ID="lnkFolks1" runat="server" NavigateUrl="~/Folk.aspx" Text="Folks"></asp:HyperLink>
            <asp:Button ID="logout_button" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout_button" />

        </div>
        <div class="profile-container2">
    <div class="profile-image">
        <asp:Image ID="imgProfile" runat="server" Height="150" Width="150" />
    </div>
    <div class="profile-details">
        <asp:Label ID="lblUserName" runat="server" CssClass="username-label"></asp:Label>
    </div>
</div>

        <div class="post-container">

            <asp:Repeater ID="rptPosts" runat="server" OnItemCommand="rptPosts_ItemCommand" OnItemDataBound="rptPosts_ItemDataBound">
                <ItemTemplate>
                    <div class="card">
                        <div class="card-header">
                            <h2>Title: <%# Eval("Title") %></h2>
                        </div>
                        <div class="card-body">

                            <asp:Image ID="imgPost" Height="280" Width="220" runat="server" ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("PostImage")) %>' />
                            <!--<p>By : <%# Eval("UserName") %></p>-->
                            <p>Description: <%# Eval("Description") %></p>
                            <p>Date: <%# Eval("Date", "{0:MM/dd/yyyy}") %></p>
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="btnLike" runat="server" Text="Like" CssClass='<%# ((bool)Eval("IsLiked")) ? "btn-like-liked" : "btn-like" %>' CommandName="Like" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnDislike" runat="server" Text="Dislike" CssClass='<%#((bool)Eval("IsDisliked")) ? "btn-dislike-disliked": "btn-dislike" %>' CommandName="DisLike" CommandArgument='<%# Eval("Id") %>'  />


                            <asp:Button ID="btnLikedBy" runat="server" Text="Liked By" CssClass="btn-like" CommandName="LikedBy" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnDislikedBy" runat="server" Text="Disliked By" CssClass="btn-dislike" CommandName="DislikedBy" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="DeletePost" CommandArgument='<%# Eval("Id") %>' />

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>


    </form>
</body>
</html>
