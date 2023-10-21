using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _connectify
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                byte[] profilePhoto = null;
                string Email = txtEmail.Text;
                string FirstName = txtFirstName.Text;
                string LastName = txtLastName.Text;
                string Password = txtPassword.Text;
                string userName = txtUserName.Text;
                int Age = Convert.ToInt32(txtAge.Text);
                DateTime DateOfBirth = DateTime.ParseExact(txtDateOfBirth.Text, "dd-MM-yyyy", CultureInfo.InvariantCulture);

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

                if (fileProfilePhoto.HasFile)
                {
                    int fileSize = fileProfilePhoto.PostedFile.ContentLength;
                    profilePhoto = new byte[fileSize];
                    fileProfilePhoto.PostedFile.InputStream.Read(profilePhoto, 0, fileSize);
                }
                // Add debug statements to check values
                //Response.Write("UserName: " + userName + "<br/>");
                //Response.Write("ProfilePhoto Length: " + (profilePhoto != null ? profilePhoto.Length.ToString() : "null") + "<br/>");


                // Check if the email already exists
                string checkEmailQuery = "SELECT COUNT(*) FROM [User] WHERE Email = @Email";
                string checkUserNameQuery = "SELECT COUNT(*) FROM [User] WHERE UserName = @UserName";
                SqlCommand checkEmailCmd = new SqlCommand(checkEmailQuery, con);
                SqlCommand checkUserNameCmd = new SqlCommand(checkUserNameQuery, con);
                checkEmailCmd.Parameters.AddWithValue("@Email", Email);
                checkUserNameCmd.Parameters.AddWithValue("@UserName", userName);
                int userCount1 = 0, userCount2 = 0;

                try
                {
                    con.Open();
                    userCount1 = (int)checkEmailCmd.ExecuteScalar();
                    userCount2 = (int)checkUserNameCmd.ExecuteScalar();
                }
                finally
                {
                    con.Close();
                }

                if (userCount1 > 0)
                {
                    // Email already exists, show alert
                    Response.Write("<script>alert('Email already exists.');</script>");
                }
                else if (userCount2 > 0)
                {
                    // Email already exists, show alert
                    Response.Write("<script>alert('UserName already exists.');</script>");
                }
                else
                {
                    // Email doesn't exist, proceed with registration
                    string insertQuery = "INSERT INTO [User] (FirstName, LastName, Email, Password, Age, Dob, ProfilePhoto, UserName) VALUES" +
            " (@FirstName, @LastName, @Email, @Password, @Age, @Dob, @ProfilePhoto, @UserName)";

                    try
                    {
                        using (con)
                        {
                            using (SqlCommand cmd = new SqlCommand())
                            {
                                cmd.CommandText = insertQuery;
                                cmd.Parameters.AddWithValue("@FirstName", FirstName);
                                cmd.Parameters.AddWithValue("@Email", Email);
                                cmd.Parameters.AddWithValue("@LastName", LastName);
                                cmd.Parameters.AddWithValue("@DOB", DateOfBirth);
                                cmd.Parameters.AddWithValue("@Password", Password);
                                cmd.Parameters.AddWithValue("@Age", Age);
                                cmd.Parameters.AddWithValue("@UserName", userName);

                                if (fileProfilePhoto.HasFile)
                                {
                                    cmd.Parameters.AddWithValue("@ProfilePhoto", profilePhoto);
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@ProfilePhoto", DBNull.Value);
                                }

                                cmd.Connection = con;
                                con.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }
                        Session["greet"] = true;
                        Response.Redirect("Login.aspx");
                        //Response.Redirect("SuccessPage.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Errors: " + ex.Message);
                    }
                }
            }
        }




    }
}