<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeeRequests.aspx.cs" Inherits="UniversityManagementSystem.UGCAdmin.SeeRequests" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>UGC Inbox</title>
    <link rel="stylesheet" type="text/css" href="seeReq.css" />
             <link href='https://fonts.googleapis.com/css?family=Raleway:200,300italic,500,600,700' rel='stylesheet' type='text/css'>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script>
        window.jQuery || document.write('<script src="../Scripts/jquery-1.10.2.min.js"><\/script>');
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <header>
          <p class="logo">UIS Portal</p>
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink>
        <asp:Button ID="btn_logout" runat="server" Text="Logout" OnClick="btn_logout_Click" />
        </header>


        <div class="main-container">
           <div class="img-title-box">
                <img src="inbox.png" alt="inbox"/>
                <h1>UGC Inbox</h1>
           </div>
        
             <div class="form-switch-btn-container">
            <input type="button" value="College requests" id="showClgReq"/>
            <input type="button" value="Fake Institute reports" id="showFakeReport"/>
                 <div class="bottom-arrow-1"></div>
                 <div class="bottom-arrow-2"></div>
          
             <script>
                 $(document).ready(function () {
                     $('#showClgReq').css({ 'background-color': '#0099cc', 'color': '#fff', 'border-radius': '5px', 'border': '10px solid #0099cc' });
                     $('#showClgReq').click(function () {
                         $(this).css({ 'background-color': '#0099cc', 'color': '#fff', 'border-radius': '5px', 'border': '10px solid #0099cc' });
                         $('.req-container').fadeIn(200);
                         $('.fake-report-container').hide();
                         $('.bottom-arrow-1').fadeIn(200);
                         $('.bottom-arrow-2').hide()
                         $('#showFakeReport').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                    });

                     $('#showFakeReport').click(function () {
                         $(this).css({ 'background-color': '#0099cc', 'color': '#fff', 'border-radius': '5px', 'border': '10px solid #0099cc' });
                         $('.fake-report-container').fadeIn(200);
                         $('.req-container').hide();
                         $('.bottom-arrow-2').fadeIn(200);
                         $('.bottom-arrow-1').hide()
                         $('#showClgReq').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                    });

                });
            </script>
        </div>

        <div class="req-container">
            <!--<label for="GridView1">Requests: </label>-->
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
        </div>
           
            <div class="fake-report-container">
                <!--<label for="GridView2">Fake Institutes Reports</label>-->
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="serial" HeaderText="serial" ReadOnly="True" InsertVisible="False" SortExpression="serial"></asp:BoundField>
                    <asp:BoundField DataField="fakeinstituteid" HeaderText="fakeinstituteid" SortExpression="fakeinstituteid"></asp:BoundField>
                    <asp:BoundField DataField="fakeinstitutename" HeaderText="fakeinstitutename" SortExpression="fakeinstitutename"></asp:BoundField>
                    <asp:BoundField DataField="messagebody" HeaderText="messagebody" SortExpression="messagebody"></asp:BoundField>
                    <asp:BoundField DataField="reporttime" HeaderText="reporttime" SortExpression="reporttime"></asp:BoundField>
                    <asp:BoundField DataField="Subject" HeaderText="Subject" ReadOnly="True" SortExpression="Subject"></asp:BoundField>
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
            </div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="select serial,fakeinstituteid, fakeinstitutename,messagebody,reporttime, case when reporttype='2' then 'Report about a fake university' when reporttype='1' then 'Report about a fake college' when reporttype='3' then 'Report about a college running fake programme' when reporttype='4' then 'Report about a university running fake programme' end as Subject from fakereports order by Serial desc"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="UGCInboxFetch" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="select a.Serial, case when a.subject='2' then 'Primary details updation' when a.subject='1' then 'Request new Programme' when a.subject='3' then 'General Query' end as Subject, a.MessageBody,a.InstituteID, b.InstituteName, b.Contact,b.Email  from UGCInbox a join ApprovedInstitutes b on a.InstituteID=b.InstituteID order by a.Serial desc"></asp:SqlDataSource>
   </div>
              </form>
   
</body>
</html>
