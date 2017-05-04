using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace UniversityManagementSystem.InstituteAdmin
{
    public partial class ContactUGC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthenticateUser();
            tb_InstituteID.Text = Request.Cookies["IID"].Value;
                }

        public void AuthenticateUser()
        {
            if (Request.Cookies["InstituteLoggedIn"] == null)
                Response.Redirect("InstituteAuthentication.aspx");
            else if (Request.Cookies["InstituteLoggedIn"].Value == "Y") { }

            else
                Response.Redirect("InstituteAuthentication.aspx");
        }

        protected void btn_SendMsg_Click(object sender, EventArgs e)
        {
            using (SqlConnection con_MessageSender = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_MessageSender = new SqlCommand("insert into UGCInbox values('"+tb_InstituteID.Text+"','"+ Convert.ToInt32(RadioButtonList1.SelectedValue)+"','"+tb_Message.Text+"')", con_MessageSender))
                {
                    con_MessageSender.Open();
                    if (cmd_MessageSender.ExecuteNonQuery() == 1)
                    {
                        cmd_MessageSender.CommandText = "Select max(serial) from UGCInbox";
                        lbl_status.Text = "Your request has been submitted. Your request ID is: " + cmd_MessageSender.ExecuteScalar().ToString() + ". Kindly note it down for any future references to this query.";
                    }
                    else
                        lbl_status.Text = "Could not send your message. Some error occured.";
                }
            }
        }

        protected void btn_Logout_Click(object sender, EventArgs e)
        {
            Response.Cookies["InstituteLoggedIn"].Expires = DateTime.Now.AddMinutes(-1);
            Response.Redirect(Request.RawUrl);
        }
    }
}