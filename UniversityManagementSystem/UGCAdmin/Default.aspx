<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UniversityManagementSystem.UGCAdmin.Default" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>UGC Admin :: UIS</title>
    <link rel="stylesheet" type="text/css" href="default.css" />
     <link href='https://fonts.googleapis.com/css?family=Raleway:200,300italic,500,600,700' rel='stylesheet' type='text/css'>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btn_logout" runat="server" Text="Logout" OnClick="btn_logout_Click"/>
    <div class="nav-container">
    <h1>Landing page - UGC Admins</h1>
        <div class="nav-box" >
           <img src="manage_ins.png" title="Add Institutes" width="100"/>
            <a href="AddInstitutes.aspx">Manage Institutes</a>
        </div>
            <p class="divide"></p>
        <div class="nav-box">
             <img src="inbox.png" title="Go to Inbox" width="100">
             <a href="SeeRequests.aspx">Go to Inbox</a>
        </div>
       
   <div class="nav-box">
             <img src="../totdo.png" title="Go to Inbox" alt="Some image here" width="100">
       <a href="AllApprovedInstitutes.aspx">Approved Institutes list</a>
        </div>
        <p class="divide"></p>
   <div class="nav-box">
             <img src="../monitioring.png" title="Go to Inbox" alt="Some image here" width="100">
       <a href="FakesMonitoring.aspx">Monitoring fake institutes</a>
        </div>
    </div>
        <br />
        <br />
        <br />
          <br />
        <br />
        <br />
          <br />
        <br />
        <br />
          <br />
        <br />
          <br />
        <br />
          <br />
        <br />
        <br />

        <br />
        <br />
    </form>
    
</body>
</html>
