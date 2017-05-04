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
    public partial class InstituteAuthentication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            lbl_passChange.Visible = Request.QueryString["pc"] != null ? Request.QueryString["pc"].ToString() == "y" ? true : false : false;
        }

        protected void btn_Login_Click(object sender, EventArgs e)
        {
            using (SqlConnection con_Auth = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_Auth = new SqlCommand("select count(*) from InstituteAdmins where InstituteID='" + tb_InstituteID.Text.Trim() + "' and PassPhrase ='" + tb_PassPhrase.Text.Trim() + "'", con_Auth))
                {
                    con_Auth.Open();
                    if (cmd_Auth.ExecuteScalar().ToString() == "1")
                    {
                        Response.Cookies["InstituteLoggedIn"].Value = "Y";
                        Response.Cookies["InstituteLoggedIn"].Expires = DateTime.Now.AddMinutes(20);
                        Response.Cookies["IID"].Value = tb_InstituteID.Text.Trim();
                        Response.Cookies["IID"].Expires = DateTime.Now.AddMinutes(20);
                        Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        lbl_msg.Text = "Invalid Credentials. Retry...";
                    }
                }
            }
        }

    }
}