<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMyPost.aspx.cs" Inherits="_connectify.ViewMyPost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
            <!--<script>
                function likeButtonClick(postId) {
                    console.log("Like button clicked for post ID:", postId);
                    __doPostBack('Like', postId);
                }

                function dislikeButtonClick(postId) {
                    console.log("DisLike button clicked for post ID:", postId);
                    __doPostBack('DisLike', postId);
                }
                    
                        function updateButtonCss(postId, isLiked, isDisliked) {
                            var likeButton = document.getElementById("btnLike_" + postId);
                            var dislikeButton = document.getElementById("btnDislike_" + postId);

                            if (likeButton && dislikeButton) {
                                var likeButton = document.getElementById("btnLike_" + postId);
                                var dislikeButton = document.getElementById("btnDislike_" + postId);

                                if (isLiked) {
                                    likeButton.classList.add("btn-like-liked");
                                    likeButton.classList.remove("btn-like");

                                } else {
                                    likeButton.classList.remove("btn-like-liked");
                                    likeButton.classList.add("btn-like");
                                }

                                if (isDisliked) {
                                    dislikeButton.classList.add("btn-dislike-disliked");
                                    dislikeButton.classList.remove("btn-dislike");

                                } else {
                                    dislikeButton.classList.remove("btn-dislike-disliked");
                                    dislikeButton.classList.add("btn-dislike");
                                }

                                console.log("Button CSS updated for post ID: " + postId);
                            } else {
                                console.error("Button elements not found for post ID: " + postId);
                                console.log("Like Button:", likeButton);
                                console.log("Dislike Button:", dislikeButton);

                            }
                        }
            </script>
                -->
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
            <asp:Button ID="logout_button" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-button" />

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
