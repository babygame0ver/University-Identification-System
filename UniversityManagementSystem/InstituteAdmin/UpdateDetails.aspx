<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateDetails.aspx.cs" Inherits="UniversityManagementSystem.InstituteAdmin.UpdateDetails" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Update Details :: UIS</title>
    <link href="updateDetails.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server"> 
         <header>
             <p class="logo">UIS Portal</p>
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink>
        <asp:Button ID="btn_Logout" runat="server" Text="LogOut" OnClick="btn_Logout_Click" />
            </header>
        <br />
        <br />
        <div class="main-container">
        <h1>Update Details</h1>
       <div class="title-img-box">
            <h4>
            <label for="lbl_InstituteName">Name: </label> <asp:Label ID="lbl_InstituteName" runat="server"></asp:Label><br /><br />
            <label for="lbl_InstituteID">Unique ID: </label><asp:Label ID="lbl_InstituteID" runat="server"></asp:Label>
            </h4>
        <asp:Image ID="img_LogoImage" runat="server" AlternateText="Unable to load Logo" Height="200" />
       </div>


            <center>
        Website:<asp:TextBox ID="tb_Website" runat="server" placeholder="Website" CssClass="tb"></asp:TextBox>
        <br />
        
        Alternate Contact<asp:TextBox runat="server" ID="tb_AltContact" placeholder="Alternate Contact No." CssClass="tb"></asp:TextBox>
                <br />
        Alternate Email<asp:TextBox runat="server" ID="tb_AltEmail" placeholder="Alternate Email" CssClass="tb"></asp:TextBox>
                <br />
               
                
        Primary Contact:<asp:TextBox ID="tb_Contact" runat="server" Enabled="false" ToolTip="You can not edit this information" CssClass="tb"></asp:TextBox>
                <br />
        Primary Email:<asp:TextBox ID="tb_Email" runat="server" Enabled="false" ToolTip="You can not edit this information" CssClass="tb"></asp:TextBox>
                <br />
       Established year:  <asp:TextBox ID="tb_Established" runat="server" Enabled="false" CssClass="tb"></asp:TextBox>
                <br />
        Name:<asp:TextBox ID="tb_InstituteName" runat="server" Enabled="false" ToolTip="You can not edit this information" CssClass="tb"></asp:TextBox>
                <br />
        change logo:
        <asp:FileUpload ID="fuc_LogoImage" runat="server" />
        <br />
                 <asp:Label ID="lbl_noLogo" Visible="false" runat="server" Text="No logo yet. Upload logo now." CssClass="tb"></asp:Label>

                <br /><br /><br />
        Approved Programmes(un-editable):
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProgrammeCode" DataSourceID="DynamicProgrammesList" AllowPaging="True" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="ProgrammeCode" HeaderText="ProgrammeCode" ReadOnly="True" SortExpression="ProgrammeCode"></asp:BoundField>
                <asp:BoundField DataField="ProgrammeName" HeaderText="ProgrammeName" SortExpression="ProgrammeName"></asp:BoundField>
                <asp:BoundField DataField="DateApproved" HeaderText="DateApproved" SortExpression="DateApproved"></asp:BoundField>
            </Columns>
        </asp:GridView>
                <br />
        <asp:Button ID="btn_UpdateDetails" runat="server" Text="Update Details" OnClick="btn_UpdateDetails_Click" />
                <br />
        <asp:Label ID="lbl_Status" runat="server" Text=""></asp:Label>

        <asp:SqlDataSource runat="server" ID="DynamicProgrammesList" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="ShowProgrammesOf" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter CookieName="IID" Name="InstituteID" Type="String"></asp:CookieParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:HyperLink ID="hl_UGCcom" runat="server" NavigateUrl="~/InstituteAdmin/ContactUGC.aspx">Request a change (Message to UGC)</asp:HyperLink>
                        </center>
            <br /><br /><br /><br /><br /><br /><br /><br />
                  </div>
            </form>
</body>
</html>
