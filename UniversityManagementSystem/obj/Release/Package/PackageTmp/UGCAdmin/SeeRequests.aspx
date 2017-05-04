<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeeRequests.aspx.cs" Inherits="UniversityManagementSystem.UGCAdmin.SeeRequests" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>UGC Inbox</title>
    <link rel="stylesheet" type="text/css" href="seeReq.css" />
             <link href='https://fonts.googleapis.com/css?family=Raleway:200,300italic,500,600,700' rel='stylesheet' type='text/css'>
</head>

<body>
    <form id="form1" runat="server">
          
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Landing Page</asp:HyperLink>
            
        <div class="main-container">
        <h1>UGC Inbox</h1>
        <label for="GridView1">Requests: </label>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="UGCInboxFetch" AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="Serial" HeaderText="Serial" ReadOnly="True" InsertVisible="False" SortExpression="Serial"></asp:BoundField>
                <asp:BoundField DataField="Subject" HeaderText="Subject" ReadOnly="True" SortExpression="Subject"></asp:BoundField>
                <asp:BoundField DataField="MessageBody" HeaderText="MessageBody" SortExpression="MessageBody"></asp:BoundField>

                <asp:BoundField DataField="InstituteID" HeaderText="InstituteID" SortExpression="InstituteID"></asp:BoundField>
                <asp:BoundField DataField="InstituteName" HeaderText="InstituteName" SortExpression="InstituteName"></asp:BoundField>
                <asp:BoundField DataField="Contact" HeaderText="Contact" SortExpression="Contact"></asp:BoundField>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
            </Columns>
        </asp:GridView>

            <h1>Fake Institutes Reports</h1>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="Serial" HeaderText="Serial" ReadOnly="True" InsertVisible="False" SortExpression="Serial"></asp:BoundField>
                    <asp:BoundField DataField="FakeInstituteID" HeaderText="FakeInstituteID" SortExpression="FakeInstituteID"></asp:BoundField>
                    <asp:BoundField DataField="FakeInstituteName" HeaderText="FakeInstituteName" SortExpression="FakeInstituteName"></asp:BoundField>
                    <asp:BoundField DataField="MessageBody" HeaderText="MessageBody" SortExpression="MessageBody"></asp:BoundField>
                    <asp:BoundField DataField="ReportTime" HeaderText="ReportTime" SortExpression="ReportTime"></asp:BoundField>
                </Columns>
                <EditRowStyle BackColor="#2461BF"></EditRowStyle>

                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"></FooterStyle>

                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"></HeaderStyle>

                <PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White"></PagerStyle>

                <RowStyle BackColor="#EFF3FB"></RowStyle>

                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

                <SortedAscendingCellStyle BackColor="#F5F7FB"></SortedAscendingCellStyle>

                <SortedAscendingHeaderStyle BackColor="#6D95E1"></SortedAscendingHeaderStyle>

                <SortedDescendingCellStyle BackColor="#E9EBEF"></SortedDescendingCellStyle>

                <SortedDescendingHeaderStyle BackColor="#4870BE"></SortedDescendingHeaderStyle>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="SELECT * FROM [FakeReports] ORDER BY [Serial] DESC"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="UGCInboxFetch" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="select a.Serial, case when a.subject='2' then 'Primary details updation' when a.subject='1' then 'Request new Programme' when a.subject='3' then 'General Query' end as Subject, a.MessageBody,a.InstituteID, b.InstituteName, b.Contact,b.Email  from UGCInbox a join ApprovedInstitutes b on a.InstituteID=b.InstituteID order by a.Serial desc"></asp:SqlDataSource>
    </form>
    </div>
</body>
</html>
