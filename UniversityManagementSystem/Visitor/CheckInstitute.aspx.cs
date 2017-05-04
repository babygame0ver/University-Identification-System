using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace UniversityManagementSystem.Visitor
{
    public partial class CheckInstitute : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["InstituteID"] != null)
            {
                displayInstitutePublicProfile(Request.QueryString["InstituteID"].ToString());
            }
            if (Request.QueryString["action"] != null && Request.QueryString["action"].ToString() == "y")
            {
                pnl_ReportFake.Visible = true;
                pnl_Results.Visible = false;
                pnl_VerifyInsti.Visible = false;
            }
        }

        protected void btn_CheckInstitute_Click(object sender, EventArgs e)
        {
            if(tb_InsituteNameCheck.Text!="")
            {
                string likestring = "";
                string InstituteName = tb_InsituteNameCheck.Text.Trim() + " ";

                foreach (string word in InstituteName.Split(' '))
                    if (word != string.Empty)
                        likestring += "'%" + word + "%'+";

                likestring = likestring.Substring(0, likestring.Length - 1);
                string fetchedInstituteID = string.Empty;
                using (SqlConnection con_Verifier = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd_Verifier = new SqlCommand("Select count(*) from ApprovedInstitutes where InstituteName like " + likestring, con_Verifier))
                    {
                        con_Verifier.Open();
                        if( Convert.ToInt32(cmd_Verifier.ExecuteScalar().ToString()) == 1)
                        {
                            //found by name
                            cmd_Verifier.CommandText = "select InstituteID from ApprovedInstitutes where InstituteName like " + likestring;
                            fetchedInstituteID = cmd_Verifier.ExecuteScalar().ToString();
                        }
                    }
                }
                displayInstitutePublicProfile(fetchedInstituteID);
            }
            else
            displayInstitutePublicProfile(tb_InstituteID.Text.Trim());
        }

        protected void displayInstitutePublicProfile(string InstituteID)
        {
            if (isApprovedInstitute(InstituteID))
            {
                lbl_msg.BackColor = System.Drawing.Color.Green;
                lbl_msg.ForeColor = System.Drawing.Color.White;
                lbl_msg.Text = "Approved Institute";
                pnl_ReportFake.Visible = false;

                //displaying profile here
                DataRow Institute = new CheckDegree().getDataofInstituteID(InstituteID).Rows[0];//could be used for isApprovedInstitute() as well
                DataRow OptionalDetails = getOptionalDetails(InstituteID);

                string LogoImagePath = OptionalDetails["LogoImage"].ToString();
                if (LogoImagePath != string.Empty)
                    img_logo.ImageUrl = "../" + LogoImagePath.Substring(LogoImagePath.IndexOf("Logos"));
                else
                    img_logo.AlternateText = "No logo Image for this Institute";

                //string sInstituteID = Request.QueryString["InstituteID"] == null ? tb_InstituteID.Text.Trim() : Request.QueryString["InstituteID"].ToString();
                lbl_InstituteID.Text = Institute["InstituteID"].ToString();
                lbl_InstituteName.Text = Institute["InstituteName"].ToString();
                lbl_InstituteAff.Text = Institute["AffiliationUniversity"].ToString();
                lbl_InstituteCity.Text = Institute["City"].ToString();
                lbl_InstituteState.Text = Institute["State"].ToString();
                lbl_InstituteAddress.Text = Institute["Address"].ToString();
                lbl_InstituteEmail.Text = Institute["Email"].ToString();
                lbl_InstituteContact.Text = Institute["Contact"].ToString();
                lbl_InstituteAffDate.Text = Institute["AffiliationDate"].ToString();
                lbl_InstituteEstablished.Text = Institute["Established"].ToString();
                lbl_InstituteType.Text = Institute["InstituteType"].ToString();

                lbl_twof.Text = Institute["twof"].ToString()=="1"? "Section 2f" : "";
                lbl_tweleveb.Text = Institute["twelveb"].ToString()== "1" ? "Section 12(B)" : "";

                // lbl_InstituteType.Text = OptionalDetails["InstituteType"].ToString();
                hl_InstituteWebsite.Text = OptionalDetails["Website"].ToString();
                hl_InstituteWebsite.NavigateUrl = "http://" + OptionalDetails["Website"].ToString();

                if (Request.QueryString["InstituteID"] == null)
                {
                    Response.Cookies["IID"].Value = InstituteID;
                    //leaving to die as soon as browsing session ends
                    gv_ProgrammesList.DataSourceID = DynamicProgrammesList_SQLdataSource1.ID;
                    gv_ProgrammesList.DataBind();
                }
                pnl_Results.Visible = true;
            }
            else
            {
                lbl_msg.BackColor = System.Drawing.Color.Red;
                lbl_msg.Text = "No record found. It can be a possible Fake institute.";
                tb_InstituteIDFake.Text = tb_InstituteID.Text;
                pnl_ReportFake.Visible = true;
                pnl_Results.Visible = false;
            }
        }

        protected bool isApprovedInstitute(string InstituteID)
        {
            if (tb_InsituteNameCheck.Text == "")
            {
                using (SqlConnection con_Verifier = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd_Verifier = new SqlCommand("Select count(*) from ApprovedInstitutes where InstituteID='" + InstituteID + "'", con_Verifier))
                    {
                        con_Verifier.Open();
                        return Convert.ToInt32(cmd_Verifier.ExecuteScalar().ToString()) == 1 ? true : false;
                    }
                }
            }
            else
            {
                //search by name 
                string likestring = "";
                string InstituteName = tb_InsituteNameCheck.Text.Trim() + " ";

                foreach (string word in InstituteName.Split(' '))
                    if(word!=string.Empty)
                        likestring += "'%" + word + "%'+";

                likestring = likestring.Substring(0, likestring.Length-1);

                using (SqlConnection con_Verifier = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd_Verifier = new SqlCommand("Select count(*) from ApprovedInstitutes where InstituteName like "+likestring, con_Verifier))
                    {
                        con_Verifier.Open();
                        return Convert.ToInt32(cmd_Verifier.ExecuteScalar().ToString()) == 1 ? true : false;
                    }
                }
            }
        }

        protected DataRow getOptionalDetails(string aInstituteID)
        {
            DataTable returner = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlDataAdapter ada = new SqlDataAdapter("Select * from InstitutesDetails where InstituteID='" + aInstituteID + "'", con))
                {
                    con.Open();
                    ada.Fill(returner);
                    con.Close();
                    return returner.Rows[0];
                }
            }
        }

        protected void btn_ReportFake_Click(object sender, EventArgs e)
        {
            DataTable fakesAlready = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlDataAdapter  ada = new SqlDataAdapter("select * from FakeReports where FakeInstituteID='" +tb_InstituteIDFake.Text+"'" , con))
                {
                    con.Open();
                    ada.Fill(fakesAlready);
                    con.Close();
                    if(fakesAlready.Rows.Count>0)
                    {
                        DataRow record = fakesAlready.Rows[0];
                        int prevCount = Convert.ToInt32(record["ReportsCount"].ToString());
                        prevCount += 1;
                        System.Diagnostics.Debug.WriteLine(prevCount + "---");
                        //is not first time reoprted
                        using (SqlCommand cmd = new SqlCommand("UPDATE FAKEREPORTS SET ReportsCount = "+ prevCount +" where FakeInstituteId='" + tb_InstituteIDFake.Text +"'", con))
                        {
                            con.Open();
                            if (cmd.ExecuteNonQuery() == 1)
                                lbl_FakeMsg.Text = "We've recieved your report. Thank you.";
                            con.Close();
                        }
                    }
                    else
                    {
                        //is first time reported
                        using (SqlCommand cmd = new SqlCommand("insert into FakeReports values('" + tb_InstituteIDFake.Text + "','" + tb_InstitueNameFake.Text + "','" + tb_MessageBody.Text + "','" + TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.FindSystemTimeZoneById("India Standard Time")) + "'," + Convert.ToInt32(rbl_ReportType.SelectedValue) + ",0)", con))
                        {
                            con.Open();
                            if (cmd.ExecuteNonQuery() == 1)
                                lbl_FakeMsg.Text = "We've recieved your report. Thank you.";
                            con.Close();
                        }
                    }
                }
            }
            /*
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("insert into FakeReports values('"+tb_InstituteIDFake.Text+"','"+tb_InstitueNameFake.Text+"','"+tb_MessageBody.Text+"','"+ TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow,TimeZoneInfo.FindSystemTimeZoneById("India Standard Time"))+"',"+ Convert.ToInt32(rbl_ReportType.SelectedValue)+")", con))
                {
                    con.Open();
                    if (cmd.ExecuteNonQuery() == 1)
                        lbl_FakeMsg.Text = "We've recieved your report. Thank you.";
                    con.Close();
                }
            }*/
        }
    }
}