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
    public partial class AddDegrees : System.Web.UI.Page
    {
        public string IID = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthenticateUser();
            IID = Request.Cookies["IID"].Value;
            lbl_UserName.Text = IID;
        }

        public void AuthenticateUser()
        {
            if (Request.Cookies["InstituteLoggedIn"] == null)
                Response.Redirect("InstituteAuthentication.aspx");
            else if (Request.Cookies["InstituteLoggedIn"].Value == "Y") { }

            else
                Response.Redirect("InstituteAuthentication.aspx");
        }

        protected void btn_Logout_Click(object sender, EventArgs e)
        {
            Response.Cookies["InstituteLoggedIn"].Expires = DateTime.Now.AddMinutes(-1);
            Response.Redirect(Request.RawUrl);
        }

        protected void btn_ChangePass_Click(object sender, EventArgs e)
        {
            if (btn_ChangePass.CommandName == "ChangePass")
            {
                pnl_ChangePass.Visible = true;
                btn_ChangePass.CommandName = "ConfirmChange";
                btn_ChangePass.Text = "Confirm Change";
            }
            else if (btn_ChangePass.CommandName == "ConfirmChange")
            {
                if (isValidLogin(Request.Cookies["IID"].Value, tb_OldPass.Text.Trim()))
                {
                    if (tb_NewPass.Text == tb_NewPassConfirm.Text)
                    {
                        if (changePassPhrase(Request.Cookies["IID"].Value, tb_NewPass.Text.Trim()))
                        {
                            btn_ChangePass.CommandName = "ChangePass";
                            btn_ChangePass.Text = "Change Password";
                            lbl_msg.Text = "Passphrase changed successfully. Redirecting...";
                            Response.Cookies["InstituteLoggedIn"].Value = "n";
                            Response.Redirect("InstituteAuthentication.aspx?pc=y");

                        }
                        else
                            lbl_msg.Text = "Some error occured while changing password";
                    }
                    else
                    {
                        lbl_msg.Text = "New Passwords do not match.";
                    }
                }
                else
                    lbl_msg.Text = "Old Password is incorrect.";
            }
        }

        private bool changePassPhrase(string IID, string NewPassphrase)
        {
            using (SqlConnection con_passChange = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_PassChange = new SqlCommand("Update InstituteAdmins set PassPhrase = '" + NewPassphrase + "' where InstituteID='" + IID + "'", con_passChange))
                {
                    con_passChange.Open();
                    return cmd_PassChange.ExecuteNonQuery() == 1 ? true : false;
                }
            }
        }

        private bool isValidLogin(string IID, string Passphrase)
        {
            using (SqlConnection con_Auth = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_Auth = new SqlCommand("select count(*) from InstituteAdmins where InstituteID='" + IID + "' and PassPhrase ='" + Passphrase + "'", con_Auth))
                {
                    con_Auth.Open();
                    if (cmd_Auth.ExecuteScalar().ToString() == "1")
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        protected void btn_AddDegree_Click(object sender, EventArgs e)
        {
            string DegreeCode = newDegreeCode();
            TimeZoneInfo IST = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
            string PhotoPath = Server.MapPath("~") + "/StudentPhotos/Photo-" + DegreeCode+".jpg";
            fuc_Photo.PostedFile.SaveAs(PhotoPath);
            
            using (SqlConnection con_DegreeAdder = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_DegreeAdder = new SqlCommand("AddNewDegree",con_DegreeAdder))
                {
                    cmd_DegreeAdder.CommandType = CommandType.StoredProcedure;

                    cmd_DegreeAdder.Parameters.AddWithValue("@DegreeCode",DegreeCode);
                    cmd_DegreeAdder.Parameters.AddWithValue("@Name",tb_Name.Text.Trim());
                    cmd_DegreeAdder.Parameters.AddWithValue("@FathersName", tb_FathersName.Text.Trim());
                    cmd_DegreeAdder.Parameters.AddWithValue("@DOB", cal_DOB.SelectedDate.ToLongDateString());
                    cmd_DegreeAdder.Parameters.AddWithValue("@ProgrammeCode", DynamicProgrammesList.SelectedValue);
                    cmd_DegreeAdder.Parameters.AddWithValue("@YearStarted", Convert.ToInt32(tb_YearStarted.Text.Trim()));
                    cmd_DegreeAdder.Parameters.AddWithValue("@YearCompleted", tb_YearCompleted.Text.Trim());
                    cmd_DegreeAdder.Parameters.AddWithValue("@Division", ddl_Division.SelectedValue);
                    cmd_DegreeAdder.Parameters.AddWithValue("@Contact", tb_Contact.Text.Trim());
                    cmd_DegreeAdder.Parameters.AddWithValue("@Address", tb_Address.Text.Trim());
                    cmd_DegreeAdder.Parameters.AddWithValue("@Photo", PhotoPath);
                    cmd_DegreeAdder.Parameters.AddWithValue("@InstituteID", Request.Cookies["IID"].Value);
                    cmd_DegreeAdder.Parameters.AddWithValue("@DegreeDate", TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, IST).ToShortDateString());

                    con_DegreeAdder.Open();
                    if ( Convert.ToInt32(cmd_DegreeAdder.ExecuteNonQuery())==1)
                        lbl_DegMsg.Text = "Degree created: " + DegreeCode;
                    else
                        lbl_DegMsg.Text = "Some Error Occured while generating degree";
                }   
            }
        }

        private string newDegreeCode()
        {
            string returner = string.Empty;
            int nextDegreeOFInstitute;
            using (SqlConnection con_DegreeCode = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd_DegreeCodeFetch = new SqlCommand("select count(*) from StudentsDataDump where InstituteID='" + Request.Cookies["IID"].Value + "'", con_DegreeCode))
                {
                    con_DegreeCode.Open();
                    nextDegreeOFInstitute = Convert.ToInt32(cmd_DegreeCodeFetch.ExecuteScalar().ToString());
                }
            }
            nextDegreeOFInstitute++;
            returner = Request.Cookies["IID"].Value + nextDegreeOFInstitute.ToString().PadLeft(5,'0');
            return returner;
        }

    }
}