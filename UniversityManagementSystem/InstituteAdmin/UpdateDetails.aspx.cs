using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace UniversityManagementSystem.InstituteAdmin
{
    public partial class UpdateDetails : System.Web.UI.Page
    {
        public string IID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthenticateUser();
            if (!IsPostBack)
            {
                lbl_InstituteID.Text = Request.Cookies["IID"].Value;
                displayDetails(Request.Cookies["IID"].Value);
            }

        }

        protected void displayDetails(string aIID)
        {
            DataRow BasicDetails = getStatsBasic(aIID);
            DataRow ExtraDetails = getStatsExtra(aIID);

            lbl_InstituteName.Text = BasicDetails["InstituteName"].ToString();

            string LogoImagePath = ExtraDetails["LogoImage"].ToString();
            if (LogoImagePath != "")
                img_LogoImage.ImageUrl = "../" + LogoImagePath.Substring(LogoImagePath.IndexOf("Logos"));
            else
                lbl_noLogo.Visible = true;

            tb_InstituteName.Text = BasicDetails["InstituteName"].ToString();
            tb_Contact.Text = BasicDetails["Contact"].ToString();
            tb_Email.Text = BasicDetails["Email"].ToString();
            tb_Website.Text = ExtraDetails["Website"].ToString();
            tb_AltEmail.Text = ExtraDetails["AlternateEmail"].ToString();
            tb_AltContact.Text = ExtraDetails["AlternateContact"].ToString();
            tb_Established.Text = BasicDetails["Established"].ToString();
            //tb_Established.Text = ExtraDetails["Established"].ToString();
        }

        protected DataRow getStatsExtra(string aIID)
        {
            DataTable returner = new DataTable();
            using (SqlConnection con_StatsFetch = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlDataAdapter ada_StatsFetch = new SqlDataAdapter("Select * from InstitutesDetails where InstituteID='" + aIID + "'", con_StatsFetch))
                {
                    ada_StatsFetch.Fill(returner);
                    return returner.Rows[0];
                }
            }
        }

        protected DataRow getStatsBasic(string aIID)
        {
            DataTable returner = new DataTable();
            using (SqlConnection con_StatsFetch = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlDataAdapter ada_StatsFetch = new SqlDataAdapter("Select * from ApprovedInstitutes where InstituteID='" + aIID + "'", con_StatsFetch))
                {
                    ada_StatsFetch.Fill(returner);
                    return returner.Rows[0];
                }
            }
        }

        public void AuthenticateUser()
        {
            if (Request.Cookies["InstituteLoggedIn"] == null)
                Response.Redirect("InstituteAuthentication.aspx");
            else if (Request.Cookies["InstituteLoggedIn"].Value == "Y") { }

            else
                Response.Redirect("InstituteAuthentication.aspx");
        }

        protected void btn_UpdateDetails_Click(object sender, EventArgs e)
        {
            using (SqlConnection con_UpdateDetails = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                string CompositeQuery = string.Empty;
                string LogoPart = string.Empty;

                if (fuc_LogoImage.HasFile)
                {
                    string LogoPath = Server.MapPath("~") + "/Logos/Logo-" + lbl_InstituteID.Text + ".jpg";
                    if (File.Exists(LogoPath)) File.Delete(LogoPath);
                    {
                        fuc_LogoImage.PostedFile.SaveAs(LogoPath);
                        LogoPart = ",LogoImage='" + LogoPath + "' ";
                    }
                }
                CompositeQuery = "update InstitutesDetails set Website='" + tb_Website.Text + "' " + LogoPart + ", AlternateContact ='" + tb_AltContact.Text + "',AlternateEmail='" + tb_AltEmail.Text + "' where InstituteID='" + lbl_InstituteID.Text + "'";
                SqlCommand cmd_UpdateDetails = new SqlCommand(CompositeQuery, con_UpdateDetails);

                con_UpdateDetails.Open();
                if (cmd_UpdateDetails.ExecuteNonQuery() == 1)
                    lbl_Status.Text = "Details Updated successfully!";
                else
                    lbl_Status.Text = "Error: Details could not be updated.";
            }
        }

        protected void btn_Logout_Click(object sender, EventArgs e)
        {
            Response.Cookies["InstituteLoggedIn"].Expires = DateTime.Now.AddMinutes(-1);
            Response.Redirect(Request.RawUrl);
        }
    }
}