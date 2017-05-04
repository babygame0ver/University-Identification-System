<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UniversityManagementSystem.Visitor.Default" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Verification Portal</title>
    <link rel="stylesheet" type="text/css" href="visitor.css" />
</head>
<body>
    <div class="nav-container">
    <form id="form1" runat="server">
        <h1>Check Authenticity</h1>
        <div class="nav-box">
            <img id="one" src="degree.png" title="Verify Degree Online" width="100">
            <a id="oneA" href="CheckDegree.aspx">Verify Degree Online</a>
             </div>
        <p class="divide"></p>
        <div class="nav-box">
            <img id="two" src="ins.png" title="Verify Institute online" width="100">
            <a id="twoA" href="CheckInstitute.aspx">Verify Institute Online</a>
        </div>
        <div style="clear:both"></div>
      <center>
            <asp:HyperLink ID="hl_ReportFake" NavigateUrl="~/Visitor/CheckInstitute.aspx#pnl_ReportFake?action=y" runat="server">Report a fake Institute</asp:HyperLink>
        </center>
      
    </form>
        </div>
</body>
</html>
