<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckDegree.aspx.cs" Inherits="UniversityManagementSystem.Visitor.CheckDegree" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Verify Institute</title>
    <link rel="stylesheet" type="text/css" href="checkDeg.css" />
</head>
<body><div class="main-container">
    <form id="form1" runat="server">
         
       
        <header>
             <p class="logo">UIS Portal</p>
             <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink>
        </header>
         <img id="one" src="degree.png" title="Verify Degree Online" width="100">
            <div class="form-container">
                <h1 class="form-title">Check Degree</h1>
        <asp:TextBox ID="tb_DegreeCode" runat="server" placeholder="Unique Degree Code"></asp:TextBox>
        <asp:Button ID="btn_CheckDegree" runat="server" Text="Check Degree" OnClick="btn_CheckDegree_Click" /><br />
        <asp:Label ID="lbl_msg" runat="server" Font-Bold="true" Font-Size="XX-Large" />
        <hr />
        <asp:Panel runat="server" ID="pnl_StudentDetailHolder" Visible="false">
            <asp:Image ID="img_Photos" Height="100" runat="server" />
            <asp:Label ID="lbl_Name" runat="server"></asp:Label>
            <asp:Label ID="lbl_FathersName" runat="server"></asp:Label>
            <asp:Label ID="lbl_DOB" runat="server"></asp:Label>
            <asp:Label ID="lbl_Programme" runat="server"></asp:Label>
            <asp:Label ID="lbl_YearStarted" runat="server"></asp:Label>
            <asp:Label ID="lbl_YearCompleted" runat="server"></asp:Label>
            <asp:Label ID="lbl_Division" runat="server"></asp:Label>
            <asp:Label ID="lbl_Contact" runat="server"></asp:Label>
            <asp:Label ID="lbl_Address" runat="server"></asp:Label>
            <asp:Label ID="lbl_DegreeApprovedDate" runat="server"></asp:Label>
            <asp:Label ID="lbl_InstituteID" runat="server"></asp:Label>
            <asp:Label ID="lbl_InstituteName" runat="server"></asp:Label>
            <asp:LinkButton ID="lb_ShowInstituteDetails" Visible="false" runat="server" Text="See institute details" OnClick="lb_ShowInstituteDetails_Click" />
        </asp:Panel>
        <hr />
        <asp:Panel ID="pnl_InstituteDetailHolder" runat="server" Visible="false">

            <asp:Label ID="lbl_InstituteAffiliation" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="lbl_InstituteCity" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="lbl_InstituteState" runat="server" Text="Label"></asp:Label>

            <asp:HyperLink ID="hl_InstitutePage" runat="server" Target="_blank">View Institute Profile</asp:HyperLink>
        </asp:Panel>

    </form>
    </div>
    </div>
</body>
</html>
