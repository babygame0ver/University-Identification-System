<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckInstitute.aspx.cs" Inherits="UniversityManagementSystem.Visitor.CheckInstitute" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Check institute</title>
    <link rel="stylesheet" type="text/css" href="checkIns.css" />
</head>
<body>
    <div class="main-container">
        
    <form id="form1" runat="server">
          <header>
              <p class="logo">UIS Portal</p>
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink>
            </header>
        <asp:Panel runat="server"  ID="pnl_VerifyInsti">
        <img src="ins.png" title="verify Institute" width="100"/>
        <div class="form-container">
            <p class="form-title">Verify Institute</p>
            <asp:TextBox ID="tb_InsituteNameCheck" runat="server" PlaceHolder="Institute Name"></asp:TextBox>

        <asp:TextBox ID="tb_InstituteID" runat="server" PlaceHolder="InstituteID"></asp:TextBox>

            <!--<p> or </p>-->
        <asp:Button ID="btn_CheckInstitute" runat="server" Text="Check Insitiute" OnClick="btn_CheckInstitute_Click" />
        <br /><asp:Label ID="lbl_msg"  runat="server" Text=""></asp:Label>
        <!--<hr />-->
            </div>
            </asp:Panel>
        <asp:Panel runat="server" Visible="false" ID="pnl_Results">
            <br /><br /><br /><br />
        <asp:Image ID="img_logo" runat="server" Height="100" AlternateText="Logo could not be loaded" />
        <div class="uni-result-box">
            
       <asp:Label ID="lbl_InstituteType" runat="server" /> 
        <asp:Label ID="lbl_InstituteName" runat="server" />
       <br />
      <div class="ins-id-box"><label for="lbl_InstituteID">Unique ID: </label><asp:Label ID="lbl_InstituteID" runat="server" /><br /></div><br />
      <br />  <label for="lbl_InstituteAff">Affiliated University: </label><asp:Label ID="lbl_InstituteAff" runat="server" /><br />
            <label for="lbl_InstituteState">State: </label><asp:Label ID="lbl_InstituteState" runat="server" /><br />
        <label for="lbl_InstituteAddress">Address: </label><asp:Label ID="lbl_InstituteAddress" runat="server" />,
            City:<asp:Label ID="lbl_InstituteCity" runat="server" /><br />
        <label for="lbl_InstituteEstablished">Established: </label><asp:Label ID="lbl_InstituteEstablished" runat="server" /><br />
        
        <label for="lbl_InstituteEmail">Email: </label><asp:Label ID="lbl_InstituteEmail" runat="server" /><br />
        <label for="lbl_InstituteContact">Contact: </label><asp:Label ID="lbl_InstituteContact" runat="server" /><br />
        <div class="ins-date-box"><label for="lbl_InstituteAffDate">Date of Affiliation: </label>
            <asp:Label ID="lbl_InstituteAffDate" runat="server" /></div>
        <label for="lbl_InstituteWeb">Website: </label>
        <asp:HyperLink ID="hl_InstituteWebsite" runat="server" />
            <br />
          <label for="hl_two">Funding and Assistance:</label> 
              <asp:HyperLink ID="hl_two" runat="server">
        <asp:Label ID="lbl_twof" runat="server"></asp:Label>
            </asp:HyperLink>
             <asp:HyperLink ID="hl_twelve" runat="server">
        <asp:Label ID="lbl_tweleveb" runat="server"></asp:Label><br />
            </asp:HyperLink>

        </div>
        <br />
        <br />
        <h2 class="check-table-title">Approved programs:</h2>
        <br />
  
        <asp:GridView ID="gv_ProgrammesList" runat="server" DataSourceID="DynamicProgrammesList_SQLdataSource" AutoGenerateColumns="False" DataKeyNames="ProgrammeCode" AllowSorting="True" AllowPaging="True">
            <EmptyDataTemplate>
                No Programmes approved for this institute yet.
            </EmptyDataTemplate>
            <Columns>
                <asp:BoundField DataField="ProgrammeCode" HeaderText="ProgrammeCode" ReadOnly="True" SortExpression="ProgrammeCode"></asp:BoundField>
                <asp:BoundField DataField="ProgrammeName" HeaderText="ProgrammeName" SortExpression="ProgrammeName"></asp:BoundField>
                <asp:BoundField DataField="DateApproved" HeaderText="DateApproved" SortExpression="DateApproved"></asp:BoundField>
                <asp:BoundField DataField="ProgrammeType" HeaderText="ProgrammeType" SortExpression="ProgrammeType"></asp:BoundField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="DynamicProgrammesList_SQLdataSource" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="ShowProgrammesOf" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="InstituteID" Name="InstituteID" Type="String"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="DynamicProgrammesList_SQLdataSource1" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="ShowProgrammesOf" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:CookieParameter CookieName="IID" Name="InstituteID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        </asp:Panel>
        <!-- report form -->
                    <asp:Panel ID="pnl_ReportFake" runat="server" Visible="false">
                <h3>Please Take a minute to report a fake Institute. This report would go directly to UGC and appropriate actions will be taken.</h3>
                <div class="report-form-box">
                <asp:TextBox ID="tb_InstituteIDFake" runat="server" PlaceHolder="InstituteID"></asp:TextBox><br />
                    <asp:TextBox ID="tb_InstitueNameFake" runat="server" placeholder="Institute Name"></asp:TextBox>
                    <h3>SUBJECT:</h3>
                    <asp:RadioButtonList ID="rbl_ReportType" runat="server">
                        <asp:ListItem Text="Report about a fake college" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Report about a fake university" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Report about a college running fake programme" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Report about a university running fake programme" Value="4"></asp:ListItem>
                    </asp:RadioButtonList>
                <asp:TextBox ID="tb_MessageBody" runat="server" TextMode="MultiLine" PlaceHolder="Give us detail about this institute. Please mention as many details as possible. (Address, Contact no., etc)"></asp:TextBox><br />
                <asp:Button ID="btn_ReportFake" runat="server" Text="Submit Report" OnClick="btn_ReportFake_Click" />
              <br />  <asp:Label ID="lbl_FakeMsg" runat="server"></asp:Label>
                    </div>               
            </asp:Panel>
    </form>
        </div>
</body>
</html>

