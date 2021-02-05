using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AS_Assignment
{
    public partial class Home : System.Web.UI.Page
    {
        string ASDBConnectionString =
        System.Configuration.ConfigurationManager.ConnectionStrings["ASDBConnection"].ConnectionString;
        byte[] Key;
        byte[] IV;
        string name = null;
        //string email = null;

        protected string decryptData(byte[] cipherText)
        {
            string plainText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                
                ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptTransform, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            
                            plainText = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return plainText;
        }

        protected void displayUserProfile(string userid)
        {
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "SELECT * FROM Account WHERE Email=@userID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@userID", userid);

            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["Firstname"] != DBNull.Value)
                        {
                            name_lbl.Text = reader["Firstname"].ToString();
                        }
                        if (reader["Email"] != DBNull.Value)
                        {
                            email_lbl.Text = reader["Email"].ToString();
                        }

                        

                        if (reader["IV"] != DBNull.Value)
                        {
                            IV = Convert.FromBase64String(reader["IV"].ToString());
                        }

                        if (reader["Key"] != DBNull.Value)
                        {
                            Key = Convert.FromBase64String(reader["Key"].ToString());
                        }
                    }
                    
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                connection.Close();
            }
        }
        
        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            Response.Redirect("Login.aspx", false);

            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_Session Id"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            }

            if (Request.Cookies["AuthToken"] != null)
            {
                Response.Cookies["AuthToken"].Value = string.Empty;
                Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
               // name = (string)Session["userID"];

               // displayUserProfile(name);
                if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                {
                    Response.Redirect("Login.aspx", false);
                }
                else
                {
                    lbl_msg.Text = "Congratulations! You are logged in";
                    lbl_msg.ForeColor = System.Drawing.Color.Green;
                }
            }
            else
            {
                Response.Redirect("Login.aspx", false);
            }
            }
            //if (Session["LoggedIn"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            //{
            //if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
            //{
            // Response.Redirect("Login.aspx", false);
            // }
            //  else
            //   {

            //    lbl_msg.Text = "Congratulations!, login is seccessful!";
            //    lbl_msg.ForeColor = System.Drawing.Color.Green;
            //     lbl_msg.Visible = true;
            //   }
            //  }
            //   else
            // {
            //     Response.Redirect("Login.aspx", false);
            //  }
       
    }
}