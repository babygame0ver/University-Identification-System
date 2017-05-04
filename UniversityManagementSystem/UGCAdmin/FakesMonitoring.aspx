<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FakesMonitoring.aspx.cs" Inherits="UniversityManagementSystem.UGCAdmin.FakesMonitoring" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h2>List of possible fake institutes</h2>
        <h2>These institutes were reported as fake for the most number of times. (more than 100 complaints)</h2>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="serial" HeaderText="serial" ReadOnly="True" InsertVisible="False" SortExpression="serial"></asp:BoundField>
                <asp:BoundField DataField="fakeinstituteid" HeaderText="fakeinstituteid" SortExpression="fakeinstituteid"></asp:BoundField>
                <asp:BoundField DataField="fakeinstitutename" HeaderText="fakeinstitutename" SortExpression="fakeinstitutename"></asp:BoundField>
                <asp:BoundField DataField="messagebody" HeaderText="messagebody" SortExpression="messagebody"></asp:BoundField>
                <asp:BoundField DataField="reporttime" HeaderText="reporttime" SortExpression="reporttime"></asp:BoundField>
                <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" ReadOnly="True"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="select serial,fakeinstituteid, fakeinstitutename,messagebody,reporttime, case when reporttype='2' then 'Report about a fake university' when reporttype='1' then 'Report about a fake college' when reporttype='3' then 'Report about a college running fake programme' when reporttype='4' then 'Report about a university running fake programme' end as Subject from fakereports where reportscount > 100 order by Serial desc">
        </asp:SqlDataSource>
    </div>
        <br />
        <br />
        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">See all Fake Reports</asp:LinkButton>
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="false">
            <h1>List all fake reports (latest reports on the top)</h1>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="serial" HeaderText="serial" ReadOnly="True" InsertVisible="False" SortExpression="serial"></asp:BoundField>
                <asp:BoundField DataField="fakeinstituteid" HeaderText="fakeinstituteid" SortExpression="fakeinstituteid"></asp:BoundField>
                <asp:BoundField DataField="fakeinstitutename" HeaderText="fakeinstitutename" SortExpression="fakeinstitutename"></asp:BoundField>
                <asp:BoundField DataField="messagebody" HeaderText="messagebody" SortExpression="messagebody"></asp:BoundField>
                <asp:BoundField DataField="reporttime" HeaderText="reporttime" SortExpression="reporttime"></asp:BoundField>
                <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" ReadOnly="True"></asp:BoundField>
            </Columns>
        </asp:GridView>
            </asp:Panel>
        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="select serial,fakeinstituteid, fakeinstitutename,messagebody,reporttime, case when reporttype='2' then 'Report about a fake university' when reporttype='1' then 'Report about a fake college' when reporttype='3' then 'Report about a college running fake programme' when reporttype='4' then 'Report about a university running fake programme' end as Subject from fakereports order by Serial desc"></asp:SqlDataSource>
    </form>
</body>
</html>
