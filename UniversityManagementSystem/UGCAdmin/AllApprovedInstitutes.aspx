<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllApprovedInstitutes.aspx.cs" Inherits="UniversityManagementSystem.UGCAdmin.AllApprovedInstitutes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="InstituteID" DataSourceID="SqlDataSource1" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="Serial" HeaderText="Serial" ReadOnly="True" InsertVisible="False" SortExpression="Serial"></asp:BoundField>
                <asp:BoundField DataField="InstituteID" HeaderText="InstituteID" ReadOnly="True" SortExpression="InstituteID"></asp:BoundField>
                <asp:BoundField DataField="InstituteName" HeaderText="InstituteName" SortExpression="InstituteName"></asp:BoundField>
                <asp:BoundField DataField="AffiliationUniversity" HeaderText="AffiliationUniversity" SortExpression="AffiliationUniversity"></asp:BoundField>
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State"></asp:BoundField>
                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"></asp:BoundField>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                <asp:BoundField DataField="Contact" HeaderText="Contact" SortExpression="Contact"></asp:BoundField>
                <asp:BoundField DataField="AffiliationDate" HeaderText="AffiliationDate" SortExpression="AffiliationDate"></asp:BoundField>
                <asp:BoundField DataField="InstituteType" HeaderText="InstituteType" SortExpression="InstituteType"></asp:BoundField>
                <asp:BoundField DataField="Established" HeaderText="Established" SortExpression="Established"></asp:BoundField>
                <asp:BoundField DataField="twof" HeaderText="twof" SortExpression="twof"></asp:BoundField>
                <asp:BoundField DataField="twelveb" HeaderText="twelveb" SortExpression="twelveb"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="SELECT * FROM [ApprovedInstitutes] order by serial desc"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
