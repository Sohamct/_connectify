using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _connectify
{
    public partial class NewPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null)
            {
                Response.Redirect("~Login.aspx");
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Response.Redirect("~/Login.aspx");
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (fileImage.HasFile)
            {
                // Read the file into a byte array
                byte[] imageData = fileImage.FileBytes;

                // Assuming you have a way to get the user ID (replace 1 with the actual user ID)
                int userId = (int)Session["UserId"];

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

                // Insert post data into the database
                string insertQuery = "INSERT INTO [Post] (UserId, PostImage, Title, Description, Date) VALUES" +
                                     " (@UserId, @PostImage, @Title, @Description, @Date)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@PostImage", imageData);
                    cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                    cmd.Parameters.AddWithValue("@Date", DateTime.Now);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        Response.Redirect("NewPost.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.Message);
                    }
                }
            }
        }




    }
}