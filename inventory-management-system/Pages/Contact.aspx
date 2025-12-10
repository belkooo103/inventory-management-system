<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="inventory_management_system.Pages.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="contact-container">
            <asp:TextBox ID="nameTextBox" runat="server" AutoPostBack="true" placeholder="Ime: "/>
            
    </div>
</asp:Content>
     <!--
         <asp:RequiredFieldValidator ID="reqName" runat="server"
    ControlToValidate="nameTextBox"
    ErrorMessage="Ime je obavezno."
    Display="Dynamic" />
    <asp:RegularExpressionValidator ID="regexName" runat="server"
    ControlToValidate="nameTextBox"
    ErrorMessage="Ime mora biti u formatu 'John Doe' (samo slova, bez brojeva i specijalnih karaktera)."
    Display="Dynamic"
    ValidationExpression="^[A-ZČĆŠĐŽ][a-zčćšđž]+( [A-ZČĆŠĐŽ][a-zčćšđž]+)+$" />
        
    <asp:RequiredFieldValidator ID="reqEmail" runat="server"
        ControlToValidate="txtEmail"
        ErrorMessage="E-mail je obavezan."
        Display="Dynamic" />

    
    <asp:RegularExpressionValidator ID="regexEmail" runat="server"
        ControlToValidate="txtEmail"
        Display="Dynamic"
        ErrorMessage="E-mail nije u ispravnom formatu ili sadrži nedozvoljene karaktere."
        ValidationExpression="^[A-Za-z0-9]+(?:\.[A-Za-z0-9]+)*@[A-Za-z0-9-]+(?:\.[A-Za-z]{2,})+$" />

    <br /><br />

  
    <label for="txtSubject">Naslov:</label>
    <asp:TextBox ID="txtSubject" runat="server" />
    <asp:RequiredFieldValidator ID="reqSubject" runat="server"
        ControlToValidate="txtSubject"
        ErrorMessage="Naslov je obavezan."
        Display="Dynamic" />

    <br /><br />

 
    <label for="txtMessage">Poruka:</label>
    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="6" />
    <asp:RequiredFieldValidator ID="reqMessage" runat="server"
        ControlToValidate="txtMessage"
        ErrorMessage="Poruka je obavezna."
        Display="Dynamic" />

    <br /><br />

    
    <asp:Button ID="btnSend" runat="server" Text="Pošalji" />
-->