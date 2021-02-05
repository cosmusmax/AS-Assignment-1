using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AS_Assignment
{
    public partial class Login : System.Web.UI.Page
    {
        //public static int MaxInvalidPasswordAttempts { get; }

        string ASDBConnectionString =
        System.Configuration.ConfigurationManager.ConnectionStrings["ASDBConnection"].ConnectionString;
        //private string errorMsg;

        protected void Page_Load(object sender, EventArgs e)
        {
            
                string pwd = tb_pwd.Text.ToString().Trim();
                string userid = tb_email.Text.ToString().Trim();
                SHA512Managed hashing = new SHA512Managed();
                string dbHash = getDBHash(userid);
                string dbSalt = getDBSalt(userid);
                try
                {
                    if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                    {
                        string pwdWithSalt = pwd + dbSalt;
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        string userHash = Convert.ToBase64String(hashWithSalt);
                        if (userHash.Equals(dbHash))
                        {
                            Session["UserID"] = userid;

                            string guid = Guid.NewGuid().ToString();
                            Session["AuthToken"] = guid;

                            Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                            Response.Redirect("Home.aspx", false);
                        }
                        else
                        {
                            lbl_errmsg.Text = "Wrong username or password!";
                            Response.Redirect("login.aspx", false);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { }

             
        }
            
        protected string getDBHash(string userid)
        {
            string h = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "select PasswordHash FROM Account WHERE Email=@USERID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["PasswordHash"] != null)
                        {
                            if (reader["PasswordHash"] != DBNull.Value)
                            {
                                h = reader["PasswordHash"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }
        protected string getDBSalt(string userid)
        {
            string s = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "select PASSWORDSALT FROM ACCOUNT WHERE Email=@USERID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PASSWORDSALT"] != null)
                        {
                            if (reader["PASSWORDSALT"] != DBNull.Value)
                            {
                                s = reader["PASSWORDSALT"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return s;
        }
        


        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        public bool ValidateCaptcha()
        {
            bool result = true;

            
            string captchaResponse = Request.Form["g-recaptcha-response"];

            
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
           
            (" https://www.google.com/recaptcha/api/siteverify?secret=6Ld6geUZAAAAANefqM-Xppp0Tsge4jZQ6pt8qhuh &response=" + captchaResponse);

            try
            {
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();

                       // lbl_gScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);

                        result = Convert.ToBoolean(jsonObject.success);//
                    }
                }
                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }
    }
            //if (tb_username.Text.Trim().Equals("username") && tb_pwd.Text.Trim().Equals("password"))
            //{
                //Session["LoggedIn"] = tb_username.Text.Trim();

                //string guid = Guid.NewGuid().ToString();
                //Session["AuthToken"] = guid;

                //Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                //Response.Redirect("Home.aspx", false);
            //}
           // else
           // {
               // lbl_msg.Text = "Wrong username or password!";
           // }
       // }
   // }


}