<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddDegrees.aspx.cs" Inherits="UniversityManagementSystem.AddDegrees" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
          <center>
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Landing Page</asp:HyperLink>
            </center>
        <br />
        <br />
        <!-- Script manager here -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <section id="TopContent">
        <asp:Button ID="btn_Logout" runat="server" Text="LogOut" OnClick="btn_Logout_Click" />

        Welcome: <asp:Label ID="lbl_UserName" runat="server"></asp:Label>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel runat="server" ID="pnl_ChangePass" Visible="false" DefaultButton="btn_ChangePass">
        <asp:TextBox ID="tb_OldPass" runat="server" placeholder ="Old password"></asp:TextBox>
        <asp:TextBox ID="tb_NewPass" runat="server" placeholder ="New password"></asp:TextBox>
        <asp:TextBox ID="tb_NewPassConfirm" runat="server" placeholder ="New password"></asp:TextBox>
                    </asp:Panel>
        <asp:Button ID="btn_ChangePass" runat="server" Text="Change Password" CommandName="ChangePass" OnClick="btn_ChangePass_Click" />
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btn_ChangePass" />
            </Triggers>
        </asp:UpdatePanel>
            </section>
        <asp:HyperLink ID="hl_UpdateDetails" NavigateUrl="~/InstituteAdmin/UpdateDetails.aspx" runat="server">Update Details</asp:HyperLink>
        <hr />
        <center>
            <asp:Label runat="server" ID="lbl_DegMsg" BackColor="Yellow" ForeColor="Black"></asp:Label>
        </center>
        <section id="BodyContent">
        <h2>Add new Student degree</h2>
            <asp:TextBox ID="tb_Name" runat="server" placeholder="Name"></asp:TextBox>
            <asp:TextBox ID="tb_FathersName" runat="server" placeholder="Father's Name"></asp:TextBox><br />
            Date of Birth:
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
            <asp:Calendar ID="cal_DOB" runat="server" Width="100" Height="100"></asp:Calendar>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cal_DOB" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:DropDownList ID="DynamicProgrammesList" runat="server" DataSourceID="DynamicProgrammesListDataSource" DataTextField="ProgrammeCode" DataValueField="ProgrammeCode"></asp:DropDownList>
            <asp:SqlDataSource runat="server" ID="DynamicProgrammesListDataSource" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="SELECT [ProgrammeCode] FROM [InstituteProgrammeMapping] WHERE ([InstituteID] = @InstituteID)">
                <SelectParameters>
                    <asp:CookieParameter CookieName="IID" Name="InstituteID" Type="String"></asp:CookieParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:TextBox ID="tb_YearStarted" runat="server" placeholder="Year Started" TextMode="Number"></asp:TextBox>
            <asp:TextBox ID="tb_YearCompleted" runat="server" placeholder="Year Completed" TextMode="Number"></asp:TextBox>
            <asp:DropDownList runat="server" ID="ddl_Division">
                <asp:ListItem Value="0" Text="---select Division Secured---" />
                <asp:ListItem Value="1" Text="1st Division" />
                <asp:ListItem Value="2" Text="2nd Division" />
                <asp:ListItem Value="3" Text="3rd Division" />
            </asp:DropDownList>
            <asp:TextBox ID="tb_Contact" TextMode="Phone" runat="server"  placeholder="Phone"></asp:TextBox>
            <asp:TextBox ID="tb_Address" TextMode="MultiLine" runat="server" placeholder="Address"></asp:TextBox>
            <asp:FileUpload ID="fuc_Photo" runat="server" AllowMultiple="false" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fuc_Photo" Text="*" ErrorMessage="Upload a photo"></asp:RequiredFieldValidator>
            <asp:Button ID="btn_AddDegree" runat="server" Text="Add Degree" OnClick="btn_AddDegree_Click" />
            </section>
    </form>
</body>
</html>
