<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateDetails.aspx.cs" Inherits="UniversityManagementSystem.InstituteAdmin.UpdateDetails" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Update Details :: UIS</title>
</head>
<body>
    <form id="form1" runat="server"> 
         <center>
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Landing Page</asp:HyperLink>
            </center>
        <br />
        <br />
        <h1>Update Details</h1>
        <h4>
          <asp:Label ID="lbl_InstituteName" runat="server"></asp:Label>:<asp:Label ID="lbl_InstituteID" runat="server"></asp:Label>
        </h4>
        
        Website:<asp:TextBox ID="tb_Website" runat="server" placeholder="Website"></asp:TextBox>
        <asp:Image ID="img_LogoImage" runat="server" AlternateText="Unable to load Logo" Height="200" />
        <asp:Label ID="lbl_noLogo" Visible="false" runat="server" Text="No logo yet. Upload logo now."></asp:Label>
        change logo:
        <asp:FileUpload ID="fuc_LogoImage" runat="server" />
        
        Alternate Contact<asp:TextBox runat="server" ID="tb_AltContact" placeholder="Alternate Contact No."></asp:TextBox>
        Alternate Email<asp:TextBox runat="server" ID="tb_AltEmail" placeholder="Alternate Email"></asp:TextBox>

        Primary Contact:<asp:TextBox ID="tb_Contact" runat="server" Enabled="false" ToolTip="You can not edit this information"></asp:TextBox>
        Primary Email:<asp:TextBox ID="tb_Email" runat="server" Enabled="false" ToolTip="You can not edit this information"></asp:TextBox>
        <asp:TextBox ID="tb_Established" runat="server" Enabled="false"></asp:TextBox>
        Name:<asp:TextBox ID="tb_InstituteName" runat="server" Enabled="false" ToolTip="You can not edit this information"></asp:TextBox>
        Approved Programmes(un-editable):
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProgrammeCode" DataSourceID="DynamicProgrammesList" AllowPaging="True" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="ProgrammeCode" HeaderText="ProgrammeCode" ReadOnly="True" SortExpression="ProgrammeCode"></asp:BoundField>
                <asp:BoundField DataField="ProgrammeName" HeaderText="ProgrammeName" SortExpression="ProgrammeName"></asp:BoundField>
                <asp:BoundField DataField="DateApproved" HeaderText="DateApproved" SortExpression="DateApproved"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:Button ID="btn_UpdateDetails" runat="server" Text="Update Details" OnClick="btn_UpdateDetails_Click" />
        <asp:Label ID="lbl_Status" runat="server" Text=""></asp:Label>

        <asp:SqlDataSource runat="server" ID="DynamicProgrammesList" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="ShowProgrammesOf" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter CookieName="IID" Name="InstituteID" Type="String"></asp:CookieParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:HyperLink ID="hl_UGCcom" runat="server" NavigateUrl="~/InstituteAdmin/ContactUGC.aspx">Request a change (Message to UGC)</asp:HyperLink>
    </form>
</body>
</html>
