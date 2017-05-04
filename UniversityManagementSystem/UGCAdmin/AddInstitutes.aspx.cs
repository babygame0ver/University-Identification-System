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
    public partial class AddInstitutes : System.Web.UI.Page
    {
        static string ConnectionString = ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString;
        static TimeZoneInfo IST = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
        public string InstituteName = string.Empty;
        public string INSTITUTEID = string.Empty;

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

        protected void ddl_UniList_SelectedIndexChanged(object sender, EventArgs e)
        {
            tb_AffiliationUni.Text = string.Empty;
        }

        protected void lb_RemoveUniversity_Click(object sender, EventArgs e)
        {
            if (lb_RemoveUniversity.CommandName == "Remove")
            {
                ddl_RemoveUniList.Visible = true;
                ddl_RemoveInstituteList.Visible = false;
                lb_RemoveUniversity.Text = "Cancel";
                lb_RemoveUniversity.CommandName = "Cancel";
                btn_RemoveInstitute.Text = "Remove University";
                btn_RemoveInstitute.CommandName = "RemoveUniversity";
            }
            else if (lb_RemoveUniversity.CommandName == "Cancel")
            {
                ddl_RemoveUniList.Visible = false;
                ddl_RemoveInstituteList.Visible = true;
                lb_RemoveUniversity.Text = "or remove a University";
                lb_RemoveUniversity.CommandName = "Remove";
                btn_RemoveInstitute.Text = "Remove Institute";
                btn_RemoveInstitute.CommandName = "RemoveInstitute";
                btn_RemoveInstitute.CommandArgument = "Confirmer";
            }
        }

        protected void btn_RemoveInstitute_Click(object sender, EventArgs e)
        {
            if (btn_RemoveInstitute.CommandArgument == "Confirmer")
            {
                btn_Cancel.Visible = false;

                if (btn_RemoveInstitute.CommandName == "RemoveInstitute")
                {
                    btn_RemoveInstitute.CommandArgument = "Confirm";
                    btn_RemoveInstitute.Text = "Confirm Remove Institute";
                    lb_RemoveUniversity.Enabled = false;
                    lb_RemoveUniversity.ToolTip = "Disabled";
                    btn_Cancel.Visible = true;
                }
                else if (btn_RemoveInstitute.CommandName == "RemoveUniversity")
                {
                    btn_RemoveInstitute.CommandArgument = "Confirm";
                    btn_RemoveInstitute.Text = "Confirm Remove University";
                    lbl_UniLinkedInstitutesWarning.Visible = true;
                    using (SqlConnection con_Remover = new SqlConnection(ConnectionString))
                    {
                        using (SqlDataAdapter ada_FetchInstitute = new SqlDataAdapter("Select InstituteName from ApprovedInstitutes where AffiliationUniversity='" + ddl_RemoveUniList.SelectedValue + "' and InstituteName!=AffiliationUniversity", con_Remover))
                        {
                            DataTable TempInstitutesList = new DataTable();
                            ada_FetchInstitute.Fill(TempInstitutesList);

                            gv_UniLinkedInstitutes.DataSource = TempInstitutesList;
                            gv_UniLinkedInstitutes.DataBind();
                        }
                    }
                    btn_Cancel.Visible = true;
                }
            }
            else if (btn_RemoveInstitute.CommandArgument == "Confirm")
            {
                using (SqlConnection con_Remover = new SqlConnection(ConnectionString))
                {

                    using (SqlCommand cmd_Remover = new SqlCommand())
                    {
                        cmd_Remover.Connection = con_Remover;
                        string RemoveObject = string.Empty;

                        switch (btn_RemoveInstitute.CommandName)
                        {
                            case "RemoveInstitute":
                                System.Diagnostics.Debug.WriteLine("Remove Institiute here.");
                                lbl_UniLinkedInstitutesWarning.Visible = false;
                                RemoveObject = "InstituteName";
                                break;
                            case "RemoveUniversity":
                                System.Diagnostics.Debug.WriteLine("Remove Uni here.");
                                RemoveObject = "AffiliationUniversity";
                                break;
                            default:
                                System.Diagnostics.Debug.WriteLine("DDL Read Error.");
                                break;
                        }
                        string RemoverParameter = RemoveObject == "InstituteName" ? ddl_RemoveInstituteList.SelectedValue : ddl_RemoveUniList.SelectedValue;
                        cmd_Remover.CommandText = "Delete from ApprovedInstitutes where " + RemoveObject + "='" + RemoverParameter + "'";

                        con_Remover.Open();
                        if (cmd_Remover.ExecuteNonQuery() > 0)
                            btn_RemoveInstitute.Text = "Removed " + RemoverParameter;
                        else
                            btn_RemoveInstitute.Text = "Some error occured";
                        btn_Cancel.Text = "Refresh Lists";
                    }
                }
            }
        }

        protected void btn_Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btn_AddNewInstitute_Click(object sender, EventArgs e)
        {

            if (giveSelectedProgrammes().Rows.Count < 1)
            {
                lbl_IID.BackColor = System.Drawing.Color.OrangeRed;
                lbl_IID.Text = "Select Programs offered by this institute. Retry...";
                lb_SelectProgrammes_Click(new object(), new EventArgs());
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("COLUMNS-" + giveSelectedProgrammes().Columns.Count + "-");
                System.Diagnostics.Debug.WriteLine("ROWS-" + giveSelectedProgrammes().Rows.Count + "-");
                string AffiliationUniversity = tb_AffiliationUni.Text == string.Empty ? ddl_UniList.SelectedValue : tb_AffiliationUni.Text.Trim();
                string InstituteID = ddl_StaticStatesList.SelectedValue.Substring(0, 3).ToUpper() + "-" + giveFirstChars(AffiliationUniversity) + "-" + giveFirstChars(tb_InstituteName.Text.Trim());
                INSTITUTEID = InstituteID;
                using (SqlConnection con_UGCAdmin = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand cmd_AddInstitute = new SqlCommand("AddNewInstitute", con_UGCAdmin))
                    {
                        cmd_AddInstitute.CommandType = CommandType.StoredProcedure;

                        cmd_AddInstitute.Parameters.AddWithValue("@InstituteID", InstituteID);
                        cmd_AddInstitute.Parameters.AddWithValue("@InstituteName", tb_InstituteName.Text.Trim());
                        cmd_AddInstitute.Parameters.AddWithValue("@AffUni", AffiliationUniversity);
                        cmd_AddInstitute.Parameters.AddWithValue("@City", tb_City.Text.Trim());
                        cmd_AddInstitute.Parameters.AddWithValue("@State", ddl_StaticStatesList.SelectedValue);
                        cmd_AddInstitute.Parameters.AddWithValue("@Address", tb_Address.Text.Trim());
                        cmd_AddInstitute.Parameters.AddWithValue("@Email", tb_Email.Text.Trim());
                        cmd_AddInstitute.Parameters.AddWithValue("@Contact", tb_Contact.Text.Trim());
                        cmd_AddInstitute.Parameters.AddWithValue("@AffDate", TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, IST).ToShortDateString());
                        cmd_AddInstitute.Parameters.AddWithValue("@InstiType", ddl_InstituteType.Text);
                        cmd_AddInstitute.Parameters.AddWithValue("@Established", Convert.ToInt32(tb_Established.Text.Trim()));
                        cmd_AddInstitute.Parameters.AddWithValue("@twof",cb_TwoF.Checked?1:0);
                        cmd_AddInstitute.Parameters.AddWithValue("@twelveb",cb_TweleveB.Checked?1:0);
                        con_UGCAdmin.Open();

                        if (cmd_AddInstitute.ExecuteNonQuery() == 1)
                        {
                            addProgrammesList(InstituteID, giveSelectedProgrammes());
                            lbl_IID.Text = "Unique InstituteID: " + InstituteID;
                            lbl_Passphrase.Text = "Passphrase: " + createNewAccountCredentials(InstituteID);
                            btn_AddNewInstitute.Text = "Institute Added";
                            btn_AddNewInstitute.BackColor = System.Drawing.Color.Green;

                            cmd_AddInstitute.CommandType = CommandType.Text;
                            cmd_AddInstitute.CommandText = "insert into InstitutesDetails values('" + INSTITUTEID + "',null,'','',null)";
                            cmd_AddInstitute.ExecuteNonQuery();
                        }
                        else
                        {
                            btn_AddNewInstitute.Text = "Some Error Occured";
                            btn_AddNewInstitute.BackColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
        }

        protected string giveFirstChars(string WorkString)
        {
            WorkString = " " + WorkString;
            string returner = string.Empty;
            for (int c = 0; c < WorkString.Length - 1; c++)
                if (WorkString.ElementAt<char>(c) == ' ')
                    returner += WorkString.ElementAt<char>(c + 1).ToString().ToUpper();
            return returner;
        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Response.Cookies["LoggedIn"].Expires = DateTime.Now.AddMinutes(-1);
            Response.Redirect(Request.RawUrl);
        }

        private string createNewAccountCredentials(string IID)
        {
            string TemporaryPassphrase = DateTime.Now.Ticks.ToString();
            TemporaryPassphrase = TemporaryPassphrase.Substring(TemporaryPassphrase.Length - 10);

            using (SqlConnection con_UGCAdmin = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd_AddInstitute = new SqlCommand("insert into InstituteAdmins values('" + IID + "','" + TemporaryPassphrase + "')", con_UGCAdmin))
                {
                    con_UGCAdmin.Open();
                    if (cmd_AddInstitute.ExecuteNonQuery() == 1)
                        return TemporaryPassphrase;
                    else
                        throw new Exception("Some error occured while generating new password for Institute " + IID + ".");
                }
            }
        }

        protected void btn_AddNewProgram_Click(object sender, EventArgs e)
        {
            using (SqlConnection con_UGCAdmin = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd_AddInstitute = new SqlCommand("insert into UGCProgrammes values('" + tb_ProgramCode.Text.Trim() + "','" + tb_ProgramName.Text.Trim() + "','" + TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, IST).ToShortDateString() + "',"+ Convert.ToInt32(tb_Duration.Text)+",'"+ddl_ProgrammeType.SelectedItem.Text+"')", con_UGCAdmin))
                {
                    con_UGCAdmin.Open();
                    cmd_AddInstitute.ExecuteNonQuery();

                    btn_AddNewProgram.BackColor = System.Drawing.Color.Green;
                    btn_AddNewProgram.Text = tb_ProgramCode.Text.Trim() + " added successfully!";
                }
            }
        }

        protected void lb_SelectProgrammes_Click(object sender, EventArgs e)
        {
            lb_SelectProgrammes.Visible = false;
            InstituteName = tb_InstituteName.Text.Trim();
            pnl_AddProgrammes.Visible = true;
            btn_AddNewInstitute.Enabled = true;
        }

        protected DataTable giveSelectedProgrammes()
        {
            DataTable returner = new DataTable();
            returner.Columns.Add(new DataColumn("InstituteID"));
            returner.Columns.Add(new DataColumn("ProgrammeCode"));
            returner.Columns.Add(new DataColumn("DateStarted"));

            string datestared = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, IST).ToShortDateString();

            foreach (GridViewRow row in gv_ProgrammesList.Rows)
            {
                if ((row.FindControl("cb_selectProgramme") as CheckBox).Checked)
                {
                    returner.Rows.Add(INSTITUTEID, row.Cells[1].Text, datestared);
                }
            }
            return returner;
        }

        protected void addProgrammesList(string IID, DataTable WorkTable)
        {
            using (SqlConnection con_ProgrammesAdder = new SqlConnection(ConnectionString))
            {
                SqlBulkCopy sbc = new SqlBulkCopy(con_ProgrammesAdder);
                sbc.DestinationTableName = "InstituteProgrammeMapping";

                SqlBulkCopyColumnMapping cm1 = new SqlBulkCopyColumnMapping("InstituteID", "InstituteID");
                SqlBulkCopyColumnMapping cm2 = new SqlBulkCopyColumnMapping("ProgrammeCode", "ProgrammeCode");
                SqlBulkCopyColumnMapping cm3 = new SqlBulkCopyColumnMapping("DateStarted", "DateStarted");

                sbc.ColumnMappings.Add(cm1);
                sbc.ColumnMappings.Add(cm2);
                sbc.ColumnMappings.Add(cm3);

                con_ProgrammesAdder.Open();
                sbc.WriteToServer(WorkTable);
            }

        }

        protected void ddl_RemoveInstituteList_SelectedIndexChanged(object sender, EventArgs e)
        {
            btn_RemoveInstitute.CommandName = "RemoveInstitute";
            btn_RemoveInstitute.CommandArgument = "Confirmer";
            btn_RemoveInstitute.Text = "Remove Institute";
        }

        protected void ddl_RemoveUniList_SelectedIndexChanged(object sender, EventArgs e)
        {
            btn_RemoveInstitute.CommandName = "RemoveUniversity";
            btn_RemoveInstitute.CommandArgument = "Confirmer";
            btn_RemoveInstitute.Text = "Remove University";
        }

        protected void btn_RemoveProgramme_Click(object sender, EventArgs e)
        {

            string toDelete = ddl_programmesList.SelectedValue.Substring(0,ddl_programmesList.SelectedValue.IndexOf(" -"));

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("Delete from UGCProgrammes where programmecode= '"+toDelete+"'", con))
                {
                    con.Open();
                    if(cmd.ExecuteNonQuery()==1)
                    btn_RemoveProgramme.Text = "programme removed successfully.";
                    else
                        btn_RemoveProgramme.Text = "some error occured";

                }
            }
        }
    }
}