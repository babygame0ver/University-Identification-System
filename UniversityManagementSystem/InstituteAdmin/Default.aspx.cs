using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace UniversityManagementSystem.InstituteAdmin
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthenticateUser();
        }

        public void AuthenticateUser()
        {
            if (Request.Cookies["InstituteLoggedIn"] == null)
                Response.Redirect("InstituteAuthentication.aspx");
            else if (Request.Cookies["InstituteLoggedIn"].Value == "Y") { }

            else
                Response.Redirect("InstituteAuthentication.aspx");
        }

    }
}