<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Folk.aspx.cs" Inherits="_connectify.Folk" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Styles/style2.css"/>
    <title>All Folks</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
    <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="~/Home.aspx" Text="Home"></asp:HyperLink>
    <asp:HyperLink ID="lnkMyPost" runat="server" NavigateUrl="~/ViewMyPost.aspx" Text="My Post"></asp:HyperLink>
    <asp:HyperLink ID="lnkAddPost" runat="server" NavigateUrl="~/NewPost.aspx" Text="Add New Post"></asp:HyperLink>
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
