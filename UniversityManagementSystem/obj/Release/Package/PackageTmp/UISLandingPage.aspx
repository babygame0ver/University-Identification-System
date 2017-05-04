<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UISLandingPage.aspx.cs" Inherits="UniversityManagementSystem.UISLandingPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>UIS Landing Page</title>
    <link href='https://fonts.googleapis.com/css?family=Raleway:200,300italic,500,600,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="landingPage.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="nav-container">
       
            <h1>University Identification System</h1>
        
        <div class="nav-box">
          <img src="Proceed as a UGCAdmin.png" title="Proceed as a UGCAdmin" width="100">
          <a href="UGCAdmin/Default.aspx">Proceed as a UGC Admin</a>
        </div>

<p class="divide">|</p>
        <div class="nav-box">
           <img src="Proceed as an Institute Admin.png" title="Proceed as an InstituteAdmin" width="110">
            <a href="InstituteAdmin/Default.aspx">Proceed as an Institute Admin</a>
        </div>

<p class="divide">|</p>
        <div class="nav-box">
             <img src="Proceed as a Visitor.png" title="Proceed as a Visitor" width="100">
             <a href="Visitor/Default.aspx">Proceed as a Visitor </a>
         </div>  
    </div>
        

       
    </form>
</body>
</html>
