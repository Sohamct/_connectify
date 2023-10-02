using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;


namespace _connectify
{
    public partial class LikePost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.RequestType == "POST")
            {
                try
                {
                    int postId;
                    if (int.TryParse(Request.Form["postId"], out postId))
                    {
                        int userId;
                        if (int.TryParse(Request.Form["userId"], out userId))
                        {
                            // Debug statements to check postId and userId values
                            System.Diagnostics.Debug.WriteLine("postId: " + postId + ", userId: " + userId);

                            bool hasLiked = IsAlready(postId, userId, 1, 0);

                            // Create a response object
                            var response = new { status = hasLiked ? "Liked" : "NotLiked" };

                            // Serialize the response to JSON
                            string jsonResponse = new JavaScriptSerializer().Serialize(response);

                            // Set the content type and write the JSON response
                            Response.ContentType = "application/json";
                            Response.Write(jsonResponse);
                            Response.End();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Debug statement to log any exceptions
                    System.Diagnostics.Debug.WriteLine("Exception: " + ex.Message);

                    Response.ContentType = "application/json";
                    Response.Write(new JavaScriptSerializer().Serialize(new { error = ex.Message }));
                    Response.StatusCode = 500;
                    Response.End();
                }
            }
        }


        protected bool IsAlready(int pId, int uId, int like, int dislike)
        {
            bool alreadyLiked = false;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string query = "SELECT 1 FROM [Like] WHERE PostId = @PostId AND UserId = @UserId AND [DisLike] = @DisLike AND [Like] = @Like";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@PostId", pId);
                cmd.Parameters.AddWithValue("@UserId", uId);
                cmd.Parameters.AddWithValue("@Like", like);
                cmd.Parameters.AddWithValue("@DisLike", dislike);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // A record exists, indicating the user has already liked the post
                    alreadyLiked = true;
                }
            }

            return alreadyLiked;
        }
    }
}