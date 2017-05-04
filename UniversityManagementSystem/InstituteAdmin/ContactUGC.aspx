<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUGC.aspx.cs" Inherits="UniversityManagementSystem.InstituteAdmin.ContactUGC" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Request a change :: UIS</title>
    <link rel="stylesheet" type="text/css" href="contactUGC.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
     <header>
         <p class="logo">UIS Portal</p>
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink>
        <asp:Button ID="btn_Logout" runat="server" Text="LogOut" OnClick="btn_Logout_Click" />
        </header>
        <div class="main-container">
            <img src="Feedback Filled-100_1.png" width="100"/>
        <h1>Contact UGC </h1>
            <div class="contact-form-wrapper">
                <div class="up-arrow"></div>
        <asp:Panel ID="pnl_FormHolder" runat="server">
        <p class="ins-id-text">Institute ID : </p>
        <asp:TextBox ID="tb_InstituteID" runat="server" Enabled="false" ToolTip="You can not edit this"></asp:TextBox>
            <%--<p>Subject(Send separate messages if your query has issues more than one of the following) :</p>--%>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server">
            <asp:ListItem Text="Request new Programme" Value="1"></asp:ListItem>
             
            <asp:ListItem Text="Primary details updation" Value ="2"></asp:ListItem>
             
            <asp:ListItem Text="General Query" Value="3"></asp:ListItem>
           
        </asp:RadioButtonList>
        <asp:TextBox ID="tb_Message"  runat="server" TextMode="MultiLine" placeholder ="Type your query here..."></asp:TextBox>
        <asp:Button ID="btn_SendMsg" runat="server" Text="Send" OnClick="btn_SendMsg_Click" />
            </asp:Panel>
                <div class="query-response-status-box">
                    <p>Note</p>
                    <div class="up-arrow"></div>
                    <asp:Label ID="lbl_status" runat="server"></asp:Label>
                </div>
        
                <script>
                    $(document).ready(function () {
                        $('input[type=radio]').click(function () {
                            var name = $(this).attr('name');
                            name = name + '_';
                            name = name + ($(this).val() -1);
                            $('label[for=' + name + ']').css({ 'color': '#0099cc' });
                        });

                        
                    });
                </script>
                </div>
            </div>
            </form>
</body>
</html>
