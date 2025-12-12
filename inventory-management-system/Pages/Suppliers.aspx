<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Suppliers.aspx.cs" Inherits="inventory_management_system.Pages.Suppliers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

<h2 class="suppliers-title">Dobavljači</h2>

<div class="suppliers-wrapper">

    <asp:GridView ID="SuppliersGrid"
                  runat="server"
                  CssClass="grid"
                  AutoGenerateColumns="false">

        <Columns>
            <asp:BoundField DataField="name" HeaderText="Naziv" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="phone" HeaderText="Telefon" />
            <asp:BoundField DataField="address" HeaderText="Adresa" />
            <asp:BoundField DataField="created_at" HeaderText="Kreirano" DataFormatString="{0:dd.MM.yyyy}" />
        </Columns>

    </asp:GridView>

</div>

</asp:Content>

