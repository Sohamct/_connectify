using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace _connectify
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["greet"] != null && (bool) Session["greet"])
            {
                Response.Write("You have successfully registered");
            }

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text;
            string password = txtPassword.Text;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;
            string query = "SELECT Id, UserName, Password FROM [User] WHERE UserName=@UserName";

            try
            {
                using (con)
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UserName", username);
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            string dbUsername = reader["UserName"].ToString();
                            string dbPassword = reader["Password"].ToString();
                            int userId = (int)reader["Id"];

                            if (password == dbPassword)
                            {
                                // Authentication successful, redirect to a welcome page
                                Response.Write("User is valid");
                                Session["UserName"] = username;
                                Session["UserId"] = userId;
                                Response.Redirect("Home.aspx");
                            }
                            else
                            {
                                // Incorrect password
                                Response.Write("<h3 style='color:red;'>Password does not match! Please try again.</h3>");
                            }
                        }
                        else
                        {
                            // User not found
                            Response.Write("<h3 style='color:red;'>UserName does not exists!.</h3>");
                        }

                        con.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Errors: " + ex.Message);
            }
        }


    }
}