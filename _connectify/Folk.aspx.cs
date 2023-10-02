using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _connectify
{
    public partial class Folk : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    BindGridView();
                    BindGridViewFollowers();
                    BindGridViewFollowers2();
                    BindGridViewOutGoingRequests();
                    BindGridViewInComingRequests();
                    BindGridViewFollowerAndRequested();
                    BindGridViewOnlyFollowing();
                    //Response.Write(Session["UserId"]);
                }
                else
                {
                    Response.Redirect("~Login.aspx");
                }

            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Response.Redirect("~/Login.aspx");
        }

        protected void BindGridView()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM [User] WHERE Id != @CurrentUserId AND Id NOT IN (SELECT FollowingId FROM [Follower] WHERE FollowerId = @FollowerId)" +
                            "AND Id Not in(SELECT FollowerId FROM [Follower] WHERE FollowingId = @FollowerId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FollowerId", Convert.ToInt32(Session["UserId"])); // This is the follower ID
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"])); // This is the current user's ID
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                    GridViewUsers.DataSource = dt;
                    GridViewUsers.DataBind();
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }
                
            }
        }


        protected void BindGridViewFollowers()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
    SELECT UserName, ProfilePhoto, Id
    FROM [User] 
    WHERE Id IN (
        SELECT FollowerId 
        FROM [Follower] 
        WHERE FollowingId = @CurrentUserId 
        AND Status = @Status
    )
    AND Id NOT IN (
        SELECT FollowingId 
        FROM [Follower] 
        WHERE FollowerId = @CurrentUserId
    )";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"]));
                cmd.Parameters.AddWithValue("@Status", 1);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }


                GridViewFollowers.DataSource = dt;
                GridViewFollowers.DataBind();
            }
        }

        protected void BindGridViewFollowerAndRequested()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT UserName, ProfilePhoto, Id FROM [User] 
            WHERE Id IN (
                SELECT FollowerId  
                FROM [Follower] 
                WHERE FollowingId = @CurrentUserId 
                    AND Status = 1 
                    AND FollowerId IN (SELECT FollowingId 
                                FROM [Follower] 
                                WHERE FollowerId = @CurrentUserId 
                                    AND Status = 0))";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }

                GridViewFollowerAndRequested.DataSource = dt;
                GridViewFollowerAndRequested.DataBind();
            }
        }



        protected void BindGridViewFollowers2()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT * FROM [User] WHERE Id != @CurrentUserId AND Id IN (
            SELECT FollowerId FROM [Follower] WHERE FollowingId = @CurrentUserId AND Status = 1) AND Id IN (
            SELECT FollowingId FROM [Follower] WHERE FollowerId = @CurrentUserId AND Status = 1)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }


                GridViewFollowers2.DataSource = dt;
                GridViewFollowers2.DataBind();
            }
        }


        protected void BindGridViewInComingRequests()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT * FROM [User] WHERE Id IN (
            SELECT FollowerId FROM [Follower] WHERE FollowingId = @CurrentUserId AND Status = 0)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }


                GridViewInComingRequests.DataSource = dt;
                GridViewInComingRequests.DataBind();
            }
        }


        protected void BindGridViewOutGoingRequests()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT * FROM [User] WHERE Id IN (
            SELECT FollowingId FROM [Follower] WHERE FollowerId = @CurrentUserId AND Status = 0)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }


                GridViewOutGoingRequests.DataSource = dt;
                GridViewOutGoingRequests.DataBind();
            }
        }


        protected void BindGridViewOnlyFollowing()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT * FROM [User] WHERE Id IN (
            SELECT FollowingId FROM [Follower] WHERE FollowerId = @CurrentUserId AND Status = 1 AND FollowingId Not IN
            (SELECT FollowerId FROM [Follower] where FollowingId = @CurrentUserId))";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentUserId", Convert.ToInt32(Session["UserId"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                }
                catch (Exception ex)
                {
                    // Log or display the exception message for debugging
                    Response.Write("Error: " + ex.Message);
                }


                GridViewOnlyFollowing.DataSource = dt;
                GridViewOnlyFollowing.DataBind();
            }
        }

        protected void GridViewFollowers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Follow")
            {
                int followingId = Convert.ToInt32(e.CommandArgument);
                int followerId = Convert.ToInt32(Session["UserId"]);


                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO [Follower] (FollowerId, FollowingId, Status) VALUES (@FollowerId, @FollowingId, @Status)", con))
                    {
                        cmd.Parameters.AddWithValue("@FollowerId", followerId);
                        cmd.Parameters.AddWithValue("@FollowingId", followingId);
                        cmd.Parameters.AddWithValue("@Status", 0); // Assuming default status is false (0).

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGridView();
                BindGridViewFollowers();
                BindGridViewFollowers2();
                BindGridViewOutGoingRequests();
                BindGridViewInComingRequests();
                BindGridViewFollowerAndRequested();
            }

            else if (e.CommandName == "Remove")
            {
                // Logic for removing the follower
                Response.Write(e.CommandArgument);
                int followerId = Convert.ToInt32(e.CommandArgument);
                int followingId = Convert.ToInt32(Session["UserId"]);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM [Follower] WHERE FollowerId = @FollowerId AND FollowingId = @FollowingId", con))
                    {
                        cmd.Parameters.AddWithValue("@FollowerId", followerId);
                        cmd.Parameters.AddWithValue("@FollowingId", followingId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGridView();
                BindGridViewFollowers();
                BindGridViewFollowers2();
                BindGridViewOutGoingRequests();
                BindGridViewInComingRequests();
                BindGridViewFollowerAndRequested();
            }
            else if(e.CommandName == "UnFollow")
            {
                int followerId = (int)Session["UserId"];
                int followingId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM [Follower] WHERE FollowerId = @FollowerId AND FollowingId = @FollowingId", con))
                    {
                        cmd.Parameters.AddWithValue("@FollowerId", followerId);
                        cmd.Parameters.AddWithValue("@FollowingId", followingId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGridView();
                BindGridViewFollowers();
                BindGridViewFollowers2();
                BindGridViewOutGoingRequests();
                BindGridViewInComingRequests();
                BindGridViewFollowerAndRequested();
                BindGridViewOnlyFollowing();
            }

            else if (e.CommandName == "Accept")
            {
                int followingId = (int)Session["UserId"];
                int followerId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE [Follower] SET Status = @Status WHERE FollowerId = @FollowerId AND FollowingId = @FollowingId", con))
                    {
                        cmd.Parameters.AddWithValue("@FollowerId", followerId);
                        cmd.Parameters.AddWithValue("@FollowingId", followingId);
                        cmd.Parameters.AddWithValue("@Status", true); // Set to true to update the status

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGridView();
                BindGridViewFollowers();
                BindGridViewFollowers2();
                BindGridViewOutGoingRequests();
                BindGridViewInComingRequests();
                BindGridViewFollowerAndRequested();
                BindGridViewOnlyFollowing();
            }


            else if (e.CommandName == "Reject")
            {
                int followingId = (int)Session["UserId"];
                int followerId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["userConnection"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE from [Follower] WHERE FollowerId = @FollowerId AND FollowingId = @FollowingId", con))
                    {
                        cmd.Parameters.AddWithValue("@FollowerId", followerId);
                        cmd.Parameters.AddWithValue("@FollowingId", followingId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGridView();
                BindGridViewFollowers();
                BindGridViewFollowers2();
                BindGridViewOutGoingRequests();
                BindGridViewInComingRequests();
                BindGridViewFollowerAndRequested();
            }


        }




    }
}
