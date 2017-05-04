using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace UniversityManagementSystem
{
    public partial class AdminAuthentication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Authenticate_Click(object sender, EventArgs e)
        {
            if (loginUser(tb_PassPhrase.Text.Trim()))
                Response.Redirect("Default.aspx");
            else
                lbl_msg.Text = "Invalid Passphrase entered. Retry...";

        }

        public bool loginUser(string Passphrase)
        {
            using (SqlConnection con_Auth = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_Auth = new SqlCommand("select count(*) from UGCAdmins where PassPhrase ='" + Passphrase+ "'", con_Auth))
                {
                    con_Auth.Open();
                    if (cmd_Auth.ExecuteScalar().ToString() == "1")
                    {
                        Response.Cookies["LoggedIn"].Value = Passphrase;
                        Response.Cookies["LoggedIn"].Expires = DateTime.Now.AddMinutes(60);
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        public void AuthenticateUser()
        {
            using (SqlConnection con_Auth = new SqlConnection(ConfigurationManager.ConnectionStrings[0].ConnectionString))
            {
                string test = Request.Cookies["LoggedIn"].Value;
                using (SqlCommand cmd_Auth = new SqlCommand("select count(*) from UGCAdmins where PassPhrase ='" + test + "'", con_Auth))
                {
                    con_Auth.Open();
                    if (cmd_Auth.ExecuteScalar().ToString() == "1")
                    {
                        //return true;
                    }
                    else
                    {
                        Response.Redirect("AdminAuthentication.aspx");
                    }
                }
            }
        }

    }
}