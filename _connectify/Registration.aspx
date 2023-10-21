<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="_connectify.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Styles/RegistrationStyle.css"/>
    <title>Registration Page</title>
</head>
<body>
<form id="form1" runat="server">
        <div>
            <h1>Registration Form</h1>
            <div>
                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="RegistrationGroup"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ErrorMessage="Invalid email format" ForeColor="#CC0000"></asp:RegularExpressionValidator>
            </div>
            <div>
    <label for="txtUserName">Username:</label>
    <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>

            <asp:RegularExpressionValidator ID="regExUserName" runat="server" ValidationGroup="RegistrationGroup"
    ControlToValidate="txtUserName"
    ValidationExpression="^[a-zA-Z0-9]+$"
    ErrorMessage="Username can only contain letters and numbers."
    Display="Dynamic" />
            <asp:RequiredFieldValidator ID="rfvUserName" ForeColor="#CC0000" runat="server" ControlToValidate="txtUserName" ValidationGroup="RegistrationGroup"
                ErrorMessage="UserName is required"></asp:RequiredFieldValidator>

                </div>
            <div>
                <label>First Name:</label>
                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" ForeColor="#CC0000" runat="server" ControlToValidate="txtFirstName" ValidationGroup="RegistrationGroup"
                    ErrorMessage="First Name is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label>Last Name:</label>
                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" ForeColor="#CC0000" runat="server" ControlToValidate="txtLastName" ValidationGroup="RegistrationGroup"
                    ErrorMessage="Last Name is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label>Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" ForeColor="#CC0000" runat="server" ControlToValidate="txtPassword" ValidationGroup="RegistrationGroup"
    ErrorMessage="Password is required"></asp:RequiredFieldValidator>
            </div>
            <div>
                <label>Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" ForeColor="#CC0000" runat="server" ControlToValidate="txtConfirmPassword" ValidationGroup="RegistrationGroup"
ErrorMessage="Confirm Password is required"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPassword" ForeColor="#CC0000" runat="server" ControlToValidate="txtConfirmPassword" ValidationGroup="RegistrationGroup"
                    ControlToCompare="txtPassword" ErrorMessage="Passwords must match"></asp:CompareValidator> 
            </div>
            <div>
                <label>Age:</label>
                <asp:TextBox ID="txtAge" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAge" ForeColor="#CC0000" runat="server" ControlToValidate="txtAge" ValidationGroup="RegistrationGroup"
                    ErrorMessage="Age is required"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvAge" runat="server" ForeColor="#CC0000" ControlToValidate="txtAge" ValidationGroup="RegistrationGroup"
                    MinimumValue="6" MaximumValue="150" Type="Integer"
                    ErrorMessage="Age must be greater than 5"></asp:RangeValidator>
            </div>
            <div>
                <label>Date of Birth:</label>
                <asp:TextBox ID="txtDateOfBirth" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDateOfBirth" ForeColor="#CC0000" runat="server" ControlToValidate="txtDateOfBirth" ValidationGroup="RegistrationGroup"
                    ErrorMessage="Date of Birth is required"></asp:RequiredFieldValidator>
            </div>
           
            <div>
                 <label for="fileProfilePhoto">Profile Photo:</label>
                <asp:FileUpload ID="fileProfilePhoto" runat="server" />

            </div>
             <div>
     <asp:Button ID="btnRegister" CssClass="signup-button" runat="server" Text="Register" OnClick="btnRegister_Click" ValidationGroup="RegistrationGroup"/>
                 <asp:Button ID="bbtnLogin" CssClass="login-button" runat="server" Text="Login" OnClick="btnLogin_Click" />
 </div>
        </div>
    </form>
</body>
</html>
