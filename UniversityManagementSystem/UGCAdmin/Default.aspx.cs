using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace UniversityManagementSystem.UGCAdmin
{
    public partial class Default : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthenticateUser();
        }

        public void AuthenticateUser()
        {
            if (Request.Cookies["LoggedIn"] == null)
                Response.Redirect("AdminAuthentication.aspx");
            else
            {
                using (SqlConnection con_Auth = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand cmd_Auth = new SqlCommand("select count(*) from UGCAdmins where PassPhrase ='" + Request.Cookies["LoggedIn"].Value + "'", con_Auth))
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

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Response.Cookies["LoggedIn"].Expires = DateTime.Now.AddMinutes(-1);
            Response.Redirect(Request.RawUrl);
        }
    }
}