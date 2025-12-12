<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="inventory_management_system.Pages.Contact" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="contact-container">
        <div class="contact-subcontainer">
            <div class="contact-header">Kontaktirajte nas!</div>

     
            <asp:TextBox ID="nameTextBox" runat="server" placeholder="Ime i prezime:" CssClass="form-input" />
            <asp:RequiredFieldValidator ID="reqName" runat="server"
                ControlToValidate="nameTextBox"
                ErrorMessage="Ime je obavezno."
                CssClass="error-text"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="regexName" runat="server"
                ControlToValidate="nameTextBox"
                ErrorMessage="Ime mora biti u formatu 'John Doe' (samo slova, bez brojeva i specijalnih karaktera)."
                CssClass="error-text"
                Display="Dynamic"
                ValidationExpression="^[A-ZČĆŠĐŽ][a-zčćšđž]+( [A-ZČĆŠĐŽ][a-zčćšđž]+)+$" />

        
            <asp:TextBox ID="emailTextBox" runat="server" placeholder="email@example.com" CssClass="form-input" />
            <asp:RequiredFieldValidator ID="reqEmail" runat="server"
                ControlToValidate="emailTextBox"
                ErrorMessage="E-mail je obavezan."
                CssClass="error-text"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="regexEmail" runat="server"
                ControlToValidate="emailTextBox"
                Display="Dynamic"
                ErrorMessage="E-mail nije u ispravnom formatu ili sadrži nedozvoljene karaktere."
                CssClass="error-text"
                ValidationExpression="^[A-Za-z0-9]+(?:\.[A-Za-z0-9]+)*@[A-Za-z0-9-]+(?:\.[A-Za-z]{2,})+$" />

            
            <asp:TextBox ID="messageHeaderTextBox" runat="server" placeholder="Unesite naslov: " CssClass="form-input" />
            <asp:RequiredFieldValidator ID="reqSubject" runat="server"
                ControlToValidate="messageHeaderTextBox"
                ErrorMessage="Naslov je obavezan."
                CssClass="error-text"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
            ControlToValidate="messageHeaderTextBox"
             Display="Dynamic"
             ErrorMessage="Naslov poruke sadrži nedozvoljene karaktere (molimo bez specijalnih karaktera/simbola)."
            CssClass="error-text"
            ValidationExpression="^[a-zA-ZčćžšđČĆŽŠĐ\s]+$" />
            
            <asp:TextBox ID="messageTextArea" runat="server" TextMode="MultiLine" CssClass="form-input" placeholder="Molimo za opsirnije objasnjenje." />
            <asp:RequiredFieldValidator ID="reqMessage" runat="server"
                ControlToValidate="messageTextArea"
                ErrorMessage="Poruka je obavezna."
                CssClass="error-text"
                Display="Dynamic"
                />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                ControlToValidate="messageTextArea"
                Display="Dynamic"
                ErrorMessage="Poruka sadrži nedozvoljene karaktere (molimo bez specijalnih karaktera/simbola)."
                CssClass="error-text"
                ValidationExpression="^^[a-zA-ZčćžšđČĆŽŠĐ\s]+$" />
            <asp:Button ID="submitButton" runat="server" Text="Pošalji" OnClick="submitButton_Click"/>
            <p id="sendMessage" runat="server" style="color:green;"></p>
        </div>
    </div>

</asp:Content>