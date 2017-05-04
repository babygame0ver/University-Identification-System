<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InstituteAuthentication.aspx.cs" Inherits="UniversityManagementSystem.InstituteAuthentication" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="insAuth.css" />
</head>
<body>
    <div class="main-container">
    <form id="form1" runat="server">
         <img id="two" src="Proceed as an Institute admin.png" title="Proceed as an Institute admin" width="100">
       <div class="form-container">
           <p class="form-title">Sign in</p>
           <p class="alernate-account">Use your Institute account</p>
            <asp:Label ID="lbl_passChange" Visible="false" runat="server" Text="Your password has been changed successfully. Login again to continue."></asp:Label>
        <br />
        <asp:TextBox ID="tb_InstituteID" runat="server" placeholder="Institute ID"></asp:TextBox>
        <br /><asp:TextBox ID="tb_PassPhrase" runat="server" placeholder ="PassPhrase" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Button ID="btn_Login" runat="server" Text="Authenticate" OnClick="btn_Login_Click" />
        <br />
        <asp:Label ID="lbl_msg" runat="server" Text=""></asp:Label>
       </div>
       
    </form>
        </div>
</body>
</html>
