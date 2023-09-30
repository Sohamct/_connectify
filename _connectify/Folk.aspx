<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Folk.aspx.cs" Inherits="_connectify.Folk" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .gridview-container {
            max-width: 800px;
            margin: 0 auto;
        }


        .profile-photo {
            max-width: 100px;
            max-height: 100px;
            width: 100%;
            height: auto;
        }
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
    <form id="form1" runat="server">
        <div class="navbar">
    <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Home.aspx" Text="Home"></asp:HyperLink>
    <asp:HyperLink ID="lnkMyPost" runat="server" NavigateUrl="~/MyPost.aspx" Text="My Post"></asp:HyperLink>
    <asp:HyperLink ID="lnkAddPost" runat="server" NavigateUrl="~/AddPost.aspx" Text="Add Post"></asp:HyperLink>
    <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-button" />
    
</div>
        <div class="gridview-container">
            <h2>Non Followers Non Followings</h2>
            <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="User Name">
                        <ItemTemplate>
                            <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Profile Photo">
                        <ItemTemplate>
                            <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnFollow" runat="server" CommandName="Follow" CommandArgument='<%# Eval("Id") %>' Text="Follow" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>




        <div>
            <h2>Users Following you but you don't</h2>
            <asp:GridView ID="GridViewFollowers" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="User Name">
                        <ItemTemplate>
                            <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Profile Photo">
                        <ItemTemplate>
                            <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnRemove" runat="server" CommandName="Remove" Text="Remove" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnFollowBack" runat="server" CommandName="Follow" CommandArgument='<%# Eval("Id") %>' Text="Followback" />

                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>






                <div>
            <h2>Users Following and you have requested</h2>
            <asp:GridView ID="GridViewFollowerAndRequested" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="User Name">
                        <ItemTemplate>
                            <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Profile Photo">
                        <ItemTemplate>
                            <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnRemove" runat="server" CommandName="Remove" Text="Remove" CommandArgument='<%# Eval("Id") %>' />
                            <asp:Button ID="btnCancel" runat="server" CommandName="UnFollow" CommandArgument='<%# Eval("Id") %>' Text="Cancel request" />

                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>







        <div>
    <h2>Your Followers and Followings</h2>
    <asp:GridView ID="GridViewFollowers2" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Profile Photo">
                <ItemTemplate>
                    <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnRemove" runat="server" CommandName="Remove" Text="Remove" CommandArgument='<%# Eval("Id") %>' />
                    <asp:Button ID="btnUnFollow" runat="server" CommandName="UnFollow" CommandArgument='<%# Eval("Id") %>' Text="UnFollow" />

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</div>



                <div>
    <h2>You follow them but they don't</h2>
    <asp:GridView ID="GridViewOnlyFollowing" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Profile Photo">
                <ItemTemplate>
                    <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnUnFollow" runat="server" CommandName="UnFollow" CommandArgument='<%# Eval("Id") %>' Text="UnFollow" />

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</div>




                <div>
    <h2>You Have Requests from </h2>
    <asp:GridView ID="GridViewInComingRequests" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Profile Photo">
                <ItemTemplate>
                    <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnAccept" runat="server" CommandName="Accept" Text="Accept" CommandArgument='<%# Eval("Id") %>' />
                    <asp:Button ID="btnReject" runat="server" CommandName="Reject" CommandArgument='<%# Eval("Id") %>' Text="Reject" />

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</div>



                <div>
    <h2>You have requested to</h2>
    <asp:GridView ID="GridViewOutGoingRequests" runat="server" AutoGenerateColumns="false" OnRowCommand="GridViewFollowers_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="User Name">
                <ItemTemplate>
                    <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Profile Photo">
                <ItemTemplate>
                    <asp:Image CssClass="profile-photo" ID="imgProfilePhoto" runat="server" 
    ImageUrl='<%# Eval("ProfilePhoto") != DBNull.Value ? "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("ProfilePhoto")) : "" %>' />

                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnCancel" runat="server" CommandName="UnFollow" Text="Cancel" CommandArgument='<%# Eval("Id") %>' />
                

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</div>




    </form>
</body>
</html>
