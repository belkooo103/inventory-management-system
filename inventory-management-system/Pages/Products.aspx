<%@ Page Title="Products"
    Language="C#"
    MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Products.aspx.cs"
    Inherits="inventory_management_system.Pages.Products" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

<h2 class="products-title">
    <%= Request.QueryString["categoryId"] != null
        ? "Proizvodi po kategoriji"
        : "Svi proizvodi" %>
</h2>

<asp:Label ID="LblMsg" runat="server" CssClass="msg" EnableViewState="false" />

<div class="add-product-panel">

    <asp:TextBox ID="TxtName" runat="server"
                 CssClass="input"
                 placeholder="Naziv proizvoda" />

    <asp:TextBox ID="TxtSku" runat="server"
                 CssClass="input"
                 placeholder="SKU" />

    <asp:TextBox ID="TxtPrice" runat="server"
                 CssClass="input"
                 placeholder="Cijena" />

    <asp:TextBox ID="TxtQuantity" runat="server"
                 CssClass="input"
                 placeholder="Količina" />

    <asp:DropDownList ID="DdlCategories"
                      runat="server"
                      CssClass="input" />

    <asp:Button ID="BtnAddProduct"
                runat="server"
                Text="Dodaj proizvod"
                CssClass="btn-add"
                OnClick="BtnAddProduct_Click"
                UseSubmitBehavior="true" />

    <asp:Button ID="BtnDeleteSelected"
                runat="server"
                Text="Obriši odabrani"
                CssClass="btn-delete-top"
                OnClick="BtnDeleteSelected_Click"
                UseSubmitBehavior="true"
                OnClientClick="return confirm('Obrisati odabrani proizvod?');" />

</div>

<div class="products-toolbar">
    <asp:TextBox ID="TxtSearch"
                 runat="server"
                 CssClass="search-box"
                 placeholder="Pretraži proizvod (naziv ili SKU)"
                 AutoPostBack="true"
                 OnTextChanged="TxtSearch_TextChanged" />
</div>

<div class="products-wrapper">

    <asp:GridView ID="ProductsGrid"
                  runat="server"
                  CssClass="grid"
                  AutoGenerateColumns="false"
                  DataKeyNames="id"
                  AutoGenerateSelectButton="true"
                  OnSelectedIndexChanged="ProductsGrid_SelectedIndexChanged">

        <Columns>
            <asp:BoundField DataField="name" HeaderText="Naziv" />
            <asp:BoundField DataField="sku" HeaderText="SKU" />
            <asp:BoundField DataField="price" HeaderText="Cijena" />
            <asp:BoundField DataField="quantity" HeaderText="Količina" />
            <asp:BoundField DataField="category" HeaderText="Kategorija" />
        </Columns>

    </asp:GridView>

</div>

</asp:Content>
