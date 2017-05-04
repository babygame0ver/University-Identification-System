<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminAuthentication.aspx.cs" Inherits="UniversityManagementSystem.AdminAuthentication" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Admin Authentication</title>
    <link rel="stylesheet" type="text/css" href="adminAuth.css" />
     <link href='https://fonts.googleapis.com/css?family=Raleway:200,300italic,500,600,700' rel='stylesheet' type='text/css'>
</head>
<body>
    <div class="main-container">
        <div class="form-container">
            <img src="ugc_admin.png" title="Proceed as a UGCAdmin" width="100">
        <p class="form-title">Sign in</p>
    <form id="form1" runat="server">
        <asp:TextBox ID="tb_PassPhrase" runat="server" placeholder="Enter the passphrase" TextMode="Password"></asp:TextBox>
        <asp:Button ID="btn_Authenticate" runat="server" Text="Authenticate" OnClick="btn_Authenticate_Click" />
        <br /><asp:Label ID="lbl_msg" runat="server"  Text=""></asp:Label>
        
    </form></div>
        </div>
</body>
</html>
