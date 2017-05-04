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
    public partial class CheckDegree : System.Web.UI.Page
    {
        public string InstituteID = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_CheckDegree_Click(object sender, EventArgs e)
        {
            DataTable StudentDetail = getDataofDegreeCode(tb_DegreeCode.Text.Trim());

            if (StudentDetail.Rows.Count == 1)
            {
                DataRow Student = StudentDetail.Rows[0];
                lbl_msg.BackColor = System.Drawing.Color.Green;
                lbl_msg.ForeColor = System.Drawing.Color.White;
                lbl_msg.Text = "Match found";

                displayStudentDetails();

            }
            else if (StudentDetail.Rows.Count == 0)
            {
                lbl_msg.BackColor = System.Drawing.Color.Red;
                lbl_msg.Text = "No Degree Found";
                pnl_InstituteDetailHolder.Visible = false;
                pnl_StudentDetailHolder.Visible = false;
            }
            else
            {
                pnl_InstituteDetailHolder.Visible = false;
                pnl_StudentDetailHolder.Visible = false;
                lbl_msg.BackColor = System.Drawing.Color.Red;
                lbl_msg.Text = "There was a problem fetching this record.";//inconsistent DB
            }
        }

        protected void displayStudentDetails()
        {
            List<string> StudentDetails = getStudentDetails(tb_DegreeCode.Text.Trim());

            lbl_Name.Text = StudentDetails[0].ToString();
            lbl_FathersName.Text = StudentDetails[1].ToString();
            lbl_DOB.Text = StudentDetails[2].ToString();
            lbl_Programme.Text = StudentDetails[3].ToString();
            lbl_YearStarted.Text = StudentDetails[4].ToString();
            lbl_YearCompleted.Text = StudentDetails[5].ToString();
            lbl_Division.Text = StudentDetails[6].ToString();
            lbl_Contact.Text = StudentDetails[7].ToString();
            lbl_Address.Text = StudentDetails[8].ToString();
            lbl_DegreeApprovedDate.Text = StudentDetails[9].ToString();
            string ImagePath = StudentDetails[10].ToString();
            img_Photos.ImageUrl = "~/"+ImagePath.Substring(ImagePath.IndexOf("StudentPhotos"));
            System.Diagnostics.Debug.WriteLine(ImagePath+"PATH PATH PATH PATH PATH");
            lbl_InstituteID.Text = StudentDetails[11].ToString();
            lbl_InstituteName.Text = StudentDetails[12].ToString();

            lb_ShowInstituteDetails.Visible = true;
            pnl_StudentDetailHolder.Visible = true;
        }

        protected void displayInstituteDetails()
        {
            List<string> InstituteDetails = getInstituteDetails(lbl_InstituteID.Text);

            lbl_InstituteName.Text = InstituteDetails[0].ToString();
            lbl_InstituteAffiliation.Text = InstituteDetails[1].ToString();
            lbl_InstituteCity.Text = InstituteDetails[2].ToString();
            lbl_InstituteState.Text = InstituteDetails[3].ToString();
            //lbl_InstituteID.Text = InstituteID;

            hl_InstitutePage.NavigateUrl = "CheckInstitute.aspx?InstituteID=" + lbl_InstituteID.Text;
            hl_InstitutePage.Visible = true;

            pnl_InstituteDetailHolder.Visible = true;
        }

        protected List<string> getStudentDetails(string DegreeCode)
        {
            DataRow Student = getDataofDegreeCode(DegreeCode).Rows[0];
            DataRow Institute = getDataofInstituteID(Student["InstituteID"].ToString()).Rows[0];

            List<string> returner = new List<string>();

            //General student details
            returner.Add(Student["Name"].ToString());//0 index
            returner.Add(Student["FathersName"].ToString());
            returner.Add(Student["DateOfBirth"].ToString());
            returner.Add(Student["ProgramCode"].ToString());
            returner.Add(Student["YearStarted"].ToString());
            returner.Add(Student["YearCompleted"].ToString());
            returner.Add(Student["DivisionSecured"].ToString());
            returner.Add(Student["Contact"].ToString());
            returner.Add(Student["Address"].ToString());
            returner.Add(Student["DegreeApprovedDate"].ToString());
            returner.Add(Student["Photo"].ToString());//10 index

            //Institute details
            returner.Add(Student["InstituteID"].ToString());

            returner.Add(Institute["InstituteName"].ToString());//13-1 index
            InstituteID = Student["InstituteID"].ToString();

            return returner;
        }

        protected List<string> getInstituteDetails(string aInstituteID)
        {
            DataRow Institute = getDataofInstituteID(aInstituteID).Rows[0];

            List<string> returner = new List<string>();

            returner.Add(Institute["InstituteName"].ToString());//0 index
            returner.Add(Institute["AffiliationUniversity"].ToString());
            returner.Add(Institute["City"].ToString());
            returner.Add(Institute["State"].ToString());
            returner.Add(Institute["Address"].ToString());
            returner.Add(Institute["Email"].ToString());
            returner.Add(Institute["Contact"].ToString());
            returner.Add(Institute["AffiliationDate"].ToString());//7 index
            returner.Add(aInstituteID);//7 index

            return returner;
        }

        public DataTable getDataofDegreeCode(string DegreeCode)
        {
            DataTable StudentDetail = new DataTable();
            using (SqlConnection con_DegreeCheck = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlDataAdapter ada_DegreeCheck = new SqlDataAdapter("Select * from StudentsDataDump where DegreeCode='" + DegreeCode + "'", con_DegreeCheck))
                {
                    con_DegreeCheck.Open();
                    ada_DegreeCheck.Fill(StudentDetail);
                }
            }
            return StudentDetail;
        }

        public DataTable getDataofInstituteID(string aInstituteID)
        {
            DataTable returner = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UISDBConnectionString"].ConnectionString))
            {
                using (SqlDataAdapter ada = new SqlDataAdapter("Select * from ApprovedInstitutes where InstituteID= '"+aInstituteID+"'", con))
                {
                    con.Open();
                    ada.Fill(returner);
                    con.Close();
                    return returner;
                }
            }
        }

        protected void lb_ShowInstituteDetails_Click(object sender, EventArgs e)
        {
            displayInstituteDetails();
        }
    }
}