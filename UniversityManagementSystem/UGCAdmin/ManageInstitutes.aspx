<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageInstitutes.aspx.cs" Inherits="UniversityManagementSystem.UGCAdmin.ManageInstitutes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        select institute:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"></asp:DropDownList>

         <br />
         <br />
                <asp:GridView runat="server" id="gv_ProgrammesList" DataSourceID="sdl_ProgrammesList">
                <Columns>
                    
                <asp:TemplateField HeaderText="Selected Programmes">
                    <ItemTemplate>
                        <asp:CheckBox ID="cb_selectProgramme" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                </Columns>
                </asp:GridView><!-- -->
    


    </div>
    </form>
</body>
</html>
