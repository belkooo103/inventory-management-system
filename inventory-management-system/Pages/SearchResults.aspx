<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="inventory_management_system.Pages.SearchResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

<h2>Rezultati pretrage</h2>

<p>
    Traženi pojam:
    <strong><%= Server.HtmlEncode(Request.QueryString["q"]) %></strong>
</p>

<asp:GridView ID="SearchGrid"
              runat="server"
              CssClass="grid"
              AutoGenerateColumns="false"
              EmptyDataText="Nema rezultata za traženi pojam.">

    <Columns>
        <asp:BoundField DataField="name" HeaderText="Naziv" />
        <asp:BoundField DataField="sku" HeaderText="SKU" />
        <asp:BoundField DataField="price" HeaderText="Cijena" />
        <asp:BoundField DataField="quantity" HeaderText="Količina" />
        <asp:BoundField DataField="category" HeaderText="Kategorija" />
    </Columns>

</asp:GridView>

</asp:Content>
