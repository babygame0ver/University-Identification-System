<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddInstitutes.aspx.cs" Inherits="UniversityManagementSystem.AddInstitutes" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Add New Institute :: UGC</title>
    <link rel="stylesheet" href="addIns.css" type="text/css" />
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
        <asp:Button ID="btn_logout" runat="server" Text="Logout" OnClick="btn_logout_Click" />
        <asp:HyperLink ID="hl_BackLink" NavigateUrl="Default.aspx" runat="server">Home</asp:HyperLink>
        </header>
        <div class="form-switch-btn-container">
            <input type="button" value="Add New University" id="addNewUni" />
            <input type="button" value="Add New Program" id="addNewProg" />
            <input type="button" value="Remove Institute" id="remIns" />
             <script>
                 $(document).ready(function () {
                     $('#addNewUni').css({ 'background-color': '#0099cc', 'color': '#fff', 'border-radius': '5px', 'border': '10px solid #0099cc' });
                     $('#addNewUni').click(function () {
                         $(this).css({ 'background-color': '#0099cc', 'color': '#fff', 'border-radius': '5px', 'border': '10px solid #0099cc' });
                        $('#AddInstitute').fadeIn(200);
                        $('#RemoveInstitute').hide();
                        $('#AddNewProgram').hide();
                        $('#addNewProg').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                        $('#remIns').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                    });

                     $('#addNewProg').click(function () {
                         $(this).css({ 'background-color': '#0099cc', 'color': '#fff', 'border-radius': '5px', 'border': '10px solid #0099cc' });
                        $('#AddNewProgram').fadeIn(200);
                        $('#AddInstitute').hide();
                        $('#RemoveInstitute').hide();
                        $('#addNewUni').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                        $('#remIns').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                    });

                     $('#remIns').click(function () {
                        $(this).css({ 'background-color': '#0099cc', 'color': '#fff','border-radius':'5px','border':'10px solid #0099cc'});
                        $('#RemoveInstitute').fadeIn(200);
                        $('#AddNewProgram').hide();
                        $('#AddInstitute').hide();
                        $('#addNewUni').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                        $('#addNewProg').css({ 'background-color': '#ddd', 'color': '#000', 'border-radius': '5px', 'border': '10px solid #ddd' });
                    });
                });
            </script>
        </div>

        <section id="AddInstitute">
            
            <!--<h1 class="add-ins-title">Add new university</h1>-->
            <br />
            <div class="add-ins-form-main-container">
                <div class="form-wrapper">
                <div class="up-arrow"></div>
                    <label for="ddl_InstituteType">Select Institute Type: </label>
                    
                    <asp:DropDownList ID="ddl_InstituteType" runat="server">
                        <asp:ListItem Text="Government"></asp:ListItem>
                        <asp:ListItem Text="Private"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="tb_Established" runat="server" PlaceHolder="Established Year"></asp:TextBox>
                   <br />
            <label for="tb_InstituteName">Institute Name :</label>
                    <asp:TextBox ID="tb_InstituteName"  runat="server"></asp:TextBox>
        
                      
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <asp:UpdatePanel ID="uppnl_Affiliation" runat="server">
                <ContentTemplate>
                    <div class="affiliated-uni-box">
                        <label for="ddl_UniList">Affiliated University</label>
                        <asp:DropDownList ID="ddl_UniList" runat="server" DataSourceID="ddl_UniList_DataSource" DataTextField="AffiliationUniversity" DataValueField="AffiliationUniversity" AutoPostBack="true" OnSelectedIndexChanged="ddl_UniList_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                  <p class="add-new-ins-or">or</p>

                    <div class="affiliated-uni-box-2">
                        <label for="tb_AffiliationUni">
                            New University
                        </label>
                        <asp:TextBox ID="tb_AffiliationUni" runat="server"></asp:TextBox>
                    </div>
                    <%--<p class="aun-text">(if adding a new university just type the University name again here)</p>--%>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddl_UniList" />
                </Triggers>
            </asp:UpdatePanel>
                     <div class="address-box">
                         <label for="tb_Address">Address:</label>
                         <asp:TextBox ID="tb_Address" runat="server" TextMode="MultiLine"></asp:TextBox>
                     </div>
                
                <div class="state-select-box">
              <label for="ddl_StaticStatesList">state:</label>
                     <asp:DropDownList ID="ddl_StaticStatesList" runat="server">
            <asp:ListItem value="0">--Select State--</asp:ListItem>
<asp:ListItem value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</asp:ListItem>
<asp:ListItem value="Andhra Pradesh">Andhra Pradesh</asp:ListItem>
<asp:ListItem value="Arunachal Pradesh">Arunachal Pradesh</asp:ListItem>
<asp:ListItem value="Assam">Assam</asp:ListItem>
<asp:ListItem value="Bihar">Bihar</asp:ListItem>
<asp:ListItem value="Chandigarh">Chandigarh</asp:ListItem>
<asp:ListItem value="Chhattisgarh">Chhattisgarh</asp:ListItem>
<asp:ListItem value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</asp:ListItem>
<asp:ListItem value="Daman and Diu">Daman and Diu</asp:ListItem>
<asp:ListItem value="Delhi">Delhi</asp:ListItem>
<asp:ListItem value="Goa">Goa</asp:ListItem>
<asp:ListItem value="Gujarat">Gujarat</asp:ListItem>
<asp:ListItem value="Haryana">Haryana</asp:ListItem>
<asp:ListItem value="Himachal Pradesh">Himachal Pradesh</asp:ListItem>
<asp:ListItem value="Jammu and Kashmir">Jammu and Kashmir</asp:ListItem>
<asp:ListItem value="Jharkhand">Jharkhand</asp:ListItem>
<asp:ListItem value="Karnataka">Karnataka</asp:ListItem>
<asp:ListItem value="Kerala">Kerala</asp:ListItem>
<asp:ListItem value="Lakshadweep">Lakshadweep</asp:ListItem>
<asp:ListItem value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
<asp:ListItem value="Maharashtra">Maharashtra</asp:ListItem>
<asp:ListItem value="Manipur">Manipur</asp:ListItem>
<asp:ListItem value="Meghalaya">Meghalaya</asp:ListItem>
<asp:ListItem value="Mizoram">Mizoram</asp:ListItem>
<asp:ListItem value="Nagaland">Nagaland</asp:ListItem>
<asp:ListItem value="Orissa">Orissa</asp:ListItem>
<asp:ListItem value="Pondicherry">Pondicherry</asp:ListItem>
<asp:ListItem value="Punjab">Punjab</asp:ListItem>
<asp:ListItem value="Rajasthan">Rajasthan</asp:ListItem>
<asp:ListItem value="Sikkim">Sikkim</asp:ListItem>
<asp:ListItem value="Telangana">Telangana</asp:ListItem>
<asp:ListItem value="Tamil Nadu">Tamil Nadu</asp:ListItem>
<asp:ListItem value="Tripura">Tripura</asp:ListItem>
<asp:ListItem value="Uttaranchal">Uttaranchal</asp:ListItem>
<asp:ListItem value="Uttar Pradesh">Uttar Pradesh</asp:ListItem>
<asp:ListItem value="West Bengal">West Bengal</asp:ListItem>
        </asp:DropDownList>
                    <div style="clear:both;"></div>
                </div>

            <div class="city-box">
                <label for="tb_City">City:</label>
                <asp:TextBox ID="tb_City" runat="server" ></asp:TextBox>
            </div>
           
           
                <br />
            <div class="email-con-box">
                <div class="email-box">
                    <label for="tb_Email">Email:</label>
                    <asp:TextBox ID="tb_Email" runat="server"  TextMode="Email"></asp:TextBox>
                </div>
                
                <div class="contact-box">
                    <label for="tb_Contact">Contact:</label>
                    <asp:TextBox ID="tb_Contact" runat="server"  TextMode="Phone"></asp:TextBox>
                </div>
            </div>
            <br />
           
           <div class="select-prog-container">
                <asp:LinkButton ID="lb_SelectProgrammes" runat="server" OnClick="lb_SelectProgrammes_Click">select approved Programmes</asp:LinkButton>


                <asp:SqlDataSource ID="sdl_ProgrammesList" runat="server" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="SELECT [ProgrammeCode], [ProgrammeName],[ProgrammeType] FROM [UGCProgrammes] ORDER BY [ProgrammeCode]"></asp:SqlDataSource>
           </div>
                 <br />
                <asp:Panel runat="server" ID="pnl_AddProgrammes" Visible="false">
                    <h3>Select courses for <span style="background:#b6ff00"><%= InstituteName %></span> </h3>
                    <!-- Dynamic courses list -->
                <asp:GridView runat="server" id="gv_ProgrammesList" DataSourceID="sdl_ProgrammesList">
                <Columns>
                    
                <asp:TemplateField HeaderText="Selected Programmes">
                    <ItemTemplate>
                        <asp:CheckBox ID="cb_selectProgramme" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                </Columns>
                </asp:GridView><!-- -->
                </asp:Panel>
                    <br />
            <asp:Button ID="btn_AddNewInstitute" runat="server" Text="Adds Institute" OnClick="btn_AddNewInstitute_Click" />
            <br />

            <asp:Label ID="lbl_IID" runat="server"></asp:Label>
            <br />
            <asp:Label ID="lbl_Passphrase" runat="server"></asp:Label>
            <asp:SqlDataSource runat="server" ID="ddl_UniList_DataSource" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="SELECT distinct(AffiliationUniversity) FROM [ApprovedInstitutes]"></asp:SqlDataSource>
        </div>
                </div>
            <!-- refresh button in program list while assingning the program-->

                </section>

        <section id="RemoveInstitute">
            <!--<h1 class="remove-ins-title">Remove Institute</h1>-->
            <div class="remove-ins-main-container">
                <div class="up-arrow"></div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <label for="ddl_RemoveInstituteList">select Institute to remove:</label><br>
                    <asp:DropDownList ID="ddl_RemoveInstituteList" runat="server" DataSourceID="ddl_RemoveInstituteList_DataSource" DataTextField="InstituteName" DataValueField="InstituteName" AutoPostBack="true" OnSelectedIndexChanged="ddl_RemoveInstituteList_SelectedIndexChanged"></asp:DropDownList>
                    <br />
                    <asp:DropDownList ID="ddl_RemoveUniList" runat="server" DataSourceID="ddl_UniList_DataSource" Visible="false" DataTextField="AffiliationUniversity" DataValueField="AffiliationUniversity" AutoPostBack="true" OnSelectedIndexChanged="ddl_RemoveUniList_SelectedIndexChanged"></asp:DropDownList>
                    <asp:LinkButton ID="lb_RemoveUniversity" OnClick="lb_RemoveUniversity_Click" runat="server" CommandName="Remove" Text="or remove a University"></asp:LinkButton>
                     <br /> <asp:Button ID="btn_RemoveInstitute" runat="server" Text="Remove Institute" OnClick="btn_RemoveInstitute_Click" CommandName="RemoveInstitute" CommandArgument="Confirmer" />
                    <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" Visible="false" OnClick="btn_Cancel_Click" />
                    <br /><br /><asp:Label ID="lbl_UniLinkedInstitutesWarning" Visible="false" runat="server" Text="The following institutes linked with selected university will also be removed. Are you sure?"></asp:Label>
            
                    <asp:GridView ID="gv_UniLinkedInstitutes" runat="server"></asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="lb_RemoveUniversity" />
                    <asp:AsyncPostBackTrigger ControlID="btn_RemoveInstitute" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="ddl_RemoveInstituteList_DataSource" runat="server" ConnectionString='<%$ ConnectionStrings:UISDBConnectionString %>' SelectCommand="SELECT [InstituteID], [InstituteName] FROM [ApprovedInstitutes] where InstituteName!=AffiliationUniversity"></asp:SqlDataSource>
        </div>
                </section>
        
               <section id="AddNewProgram">
           
            <div class="add-new-prog-main-container">
                <div class="up-arrow"></div>
                <h2>
                Add new Programme
            </h2>
            <asp:TextBox ID="tb_ProgramCode" runat="server" placeholder ="New Program Code"></asp:TextBox><br />
            <asp:TextBox ID="tb_ProgramName" runat="server" placeholder ="New Program Name"></asp:TextBox><br />
              <label for="ddl_ProgrammeType">Mode: </label>  <asp:DropDownList runat="server" ID="ddl_ProgrammeType">
                    <asp:ListItem Text="Regular">
                    </asp:ListItem>
                    <asp:ListItem Text="Distance"></asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox runat="server" ID="tb_Duration" PlaceHolder="Duration"></asp:TextBox>
            <asp:Button ID="btn_AddNewProgram" runat="server" Text="Add New Program" OnClick="btn_AddNewProgram_Click"/>
                </div>
        </section>
    </form>
</body>
</html>
