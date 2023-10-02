using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static _connectify.ViewMyPost;

namespace _connectify
{
    public partial class ViewMyPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    initialize();
                }
                else
                {
                    Response.Redirect("~Login.aspx");
                }
            }

        }

        protected void initialize()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            List<Post> posts = GetPostsByUserId(userId);
            List<int> likedPostIds = GetLikedPostIds(userId);

            // Update liked status in each post
            foreach (var post in posts)
            {
                post.IsLiked = likedPostIds.Contains(post.Id);
            }

            List<int> disLikedPostIds = GetDisLikedPostIds(userId);
            foreach (var post in posts)
            {
                post.IsDisliked = disLikedPostIds.Contains(post.Id);
            }
            rptPosts.DataSource = posts;
            rptPosts.DataBind();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Response.Redirect("~/Login.aspx");
        }



        protected List<int> GetLikedPostIds(int userId)
        {
            List<int> likedPostIds = new List<int>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string query = "SELECT PostId FROM [Like] WHERE UserId = @UserId AND [Like] = 1";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int postId = Convert.ToInt32(reader["PostId"]);
                    likedPostIds.Add(postId);
                }
            }

            return likedPostIds;
        }



        protected List<int> GetDisLikedPostIds(int userId)
        {
            List<int> likedPostIds = new List<int>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string query = "SELECT PostId FROM [Like] WHERE UserId = @UserId AND [DisLike] = 1";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int postId = Convert.ToInt32(reader["PostId"]);
                    likedPostIds.Add(postId);
                }
            }

            return likedPostIds;
        }



        private List<Post> GetPostsByUserId(int userId)
        {
            List<Post> posts = new List<Post>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string query = "SELECT P.Id, P.Title, P.Description, P.Date, P.PostImage, U.UserName " +
                       "FROM [Post] AS P INNER JOIN [User] AS U ON P.UserId = U.Id WHERE P.UserId = @UserId"; ;
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Post post = new Post
                    {
                        UserName = reader["UserName"].ToString(),
                        Id = Convert.ToInt32(reader["Id"]),
                        Title = reader["Title"].ToString(),
                        Description = reader["Description"].ToString(),
                        Date = Convert.ToDateTime(reader["Date"]),
                        PostImage = (byte[])reader["PostImage"]
                    };

                    posts.Add(post);
                }
            }

            return posts;
        }

        protected bool isAlready(int pId, int uId, int like, int dislike)
        {
            bool alreadyDisliked = false;

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
                    // A record exists, indicating the user has already disliked the post
                    alreadyDisliked = true;
                }
            }

            return alreadyDisliked;
        }

        protected void update(int pId, int uId, int like, int dislike)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {

                string updateQuery = "UPDATE [Like] SET [Like] = @Like, [DisLike] = @DisLike WHERE [PostId] = @PostId AND [UserId] = @UserId" +
                                     " AND [Like]=@_Like AND DisLike=@_DisLike";
                SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                updateCmd.Parameters.AddWithValue("@PostId", pId);
                updateCmd.Parameters.AddWithValue("@UserId", uId);
                updateCmd.Parameters.AddWithValue("@Like", like);
                updateCmd.Parameters.AddWithValue("@DisLike", dislike);
                updateCmd.Parameters.AddWithValue("@_Like", (like == 1 ? 0 : 1));
                updateCmd.Parameters.AddWithValue("@_Dislike", (dislike == 1 ? 0 : 1));
                con.Open();
                updateCmd.ExecuteNonQuery();
            }
        }

        protected void insert(int pId, int uId, int like, int dislike)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string insertQuery = "INSERT INTO [Like] ([UserId], [PostId], [Like], [DisLike]) VALUES (@UserId, @PostId,@Like, @DisLike)";

                SqlCommand cmd = new SqlCommand(insertQuery, con);
                cmd.Parameters.AddWithValue("@PostId", pId);
                cmd.Parameters.AddWithValue("@UserId", uId);
                cmd.Parameters.AddWithValue("@Like", like);
                cmd.Parameters.AddWithValue("@DisLike", dislike);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void remove(int pId, int uId, int like, int dislike)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string deleteQuery = "DELETE FROM [Like] WHERE UserId=@UserId and PostId=@PostId and [Like]=@Like and DisLike=@DisLike";

                SqlCommand cmd = new SqlCommand(deleteQuery, con);
                cmd.Parameters.AddWithValue("@PostId", pId);
                cmd.Parameters.AddWithValue("@UserId", uId);
                cmd.Parameters.AddWithValue("@Like", like);
                cmd.Parameters.AddWithValue("@DisLike", dislike);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }


        protected void deletePost(int pId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                con.Open();  // Open the connection here

                string deleteLikesQuery = "DELETE FROM [Like] WHERE PostId=@PostId";
                SqlCommand cmdLikes = new SqlCommand(deleteLikesQuery, con);
                cmdLikes.Parameters.AddWithValue("@PostId", pId);

                try
                {
                    cmdLikes.ExecuteNonQuery(); // Delete likes first
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                    con.Close();
                    return; // Return early if there's an error
                }

                string deletePostQuery = "DELETE FROM [Post] WHERE Id=@PostId";
                SqlCommand cmdPost = new SqlCommand(deletePostQuery, con);
                cmdPost.Parameters.AddWithValue("@PostId", pId);

                try
                {
                    cmdPost.ExecuteNonQuery(); // Delete post
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
                finally
                {
                    con.Close(); // Close the connection in finally block to ensure it's always closed
                }
            }
            initialize();
        }


        protected List<string> GetLikedUsers(int postId, int like)
        {
            List<string> likedUsers = new List<string>();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
            {
                string query = "SELECT U.UserName " +
                               "FROM [User] U " +
                               "INNER JOIN [Like] L ON U.Id = L.UserId " +
                               "WHERE L.PostId = @PostId AND L.[Like] = @Like";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@PostId", postId);
                cmd.Parameters.AddWithValue("@Like", like);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string userName = reader["UserName"].ToString();
                    likedUsers.Add(userName);
                }
            }

            return likedUsers;
        }




        protected void rptPosts_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Like")
            {
                try
                {
                    //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Your message goes here.');", true);

                    int PostId = Convert.ToInt32(e.CommandArgument);
                    int UserId = Convert.ToInt32(Session["UserId"]);
                    //Response.Write("psotid: " + PostId + " userid " + UserId);
                    if (isAlready(PostId, UserId, 0, 1))
                    {
                        update(PostId, UserId, 1, 0);
                    }
                    else if (isAlready(PostId, UserId, 1, 0))
                    {
                        remove(PostId, UserId, 1, 0);
                    }
                    else
                    {
                        insert(PostId, UserId, 1, 0);
                    }
                    initialize();
                    //Response.Write("Sending the reponse to client");
                    //ClientScript.RegisterStartupScript(this.GetType(), "updateButtonCss", $"updateButtonCss({PostId}, true, false);", true);
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
            }
            else if (e.CommandName == "DisLike")
            {
                try
                {
                    //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Your message goes here.');", true);

                    int PostId = Convert.ToInt32(e.CommandArgument);
                    int UserId = Convert.ToInt32(Session["UserId"]);
                    //Response.Write("psotid: " + PostId + " userid " + UserId);
                    if (isAlready(PostId, UserId, 1, 0))
                    {
                        update(PostId, UserId, 0, 1);
                    }
                    else if (isAlready(PostId, UserId, 0, 1))
                    {
                        remove(PostId, UserId, 0, 1);
                    }
                    else
                    {
                        insert(PostId, UserId, 0, 1);
                    }
                    initialize();
                    //Response.Write("Sending the reponse to client");
                    //ClientScript.RegisterStartupScript(this.GetType(), "updateButtonCss", $"updateButtonCss({PostId}, false, true);", true);
                }
                catch (Exception ex)
                {
                    Response.Write(ex.ToString());
                }
            }
            else if (e.CommandName == "LikedBy")
            {
                List<string> likedUsers = GetLikedUsers(Convert.ToInt32(e.CommandArgument), 1);


                string message = "Liked by: " + string.Join(", ", likedUsers);
                ClientScript.RegisterStartupScript(this.GetType(), "likedUsersAlert", "alert('" + message + "');", true);
            }
            else if (e.CommandName == "DisLikedBy")
            {
                List<string> disLikedUsers = GetLikedUsers(Convert.ToInt32(e.CommandArgument), 0);


                string message = "Liked by: " + string.Join(", ", disLikedUsers);
                ClientScript.RegisterStartupScript(this.GetType(), "likedUsersAlert", "alert('" + message + "');", true);
            }
            else if(e.CommandName == "DeletePost")
            {
                int postId = Convert.ToInt32(e.CommandArgument.ToString());
                deletePost(postId);
                
            }
        }



        protected void rptPosts_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //Response.Write("comming " + e.Item.ItemType);
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = e.Item.DataItem as DataRowView;
                if (rowView != null)
                {
                    int postId = Convert.ToInt32(DataBinder.Eval(rowView, "Id"));
                    int userId = Convert.ToInt32(Session["UserId"]);

                    Button btnLike = (Button)e.Item.FindControl("btnLike");
                    Button btnDislike = (Button)e.Item.FindControl("btnDislike");

                    // Check the flag or value to determine if the post has been liked or disliked
                    bool isLiked = isAlready(postId, userId, 1, 0);
                    bool isDisliked = isAlready(postId, userId, 0, 1);

                    if (isLiked)
                    {
                        btnLike.CssClass = "btn-like-liked"; // Apply a different CSS class for liked
                    }
                    else if (isDisliked)
                    {
                        btnDislike.CssClass = "btn-dislike-disliked"; // Apply a different CSS class for disliked
                    }
                }
            }
        }



        public class Post
        {
            public string UserName { get; set; }
            public int Id { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
            public DateTime Date { get; set; }
            public byte[] PostImage { get; set; }
            public bool IsLiked { get; set; }
            public bool IsDisliked { get; set; }
        }

    }
}