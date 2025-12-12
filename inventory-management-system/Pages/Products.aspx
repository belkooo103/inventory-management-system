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
                OnClick="BtnAddProduct_Click" />
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
                  OnRowCommand="ProductsGrid_RowCommand">

        <Columns>
            <asp:BoundField DataField="name" HeaderText="Naziv" />
            <asp:BoundField DataField="sku" HeaderText="SKU" />
            <asp:BoundField DataField="price" HeaderText="Cijena" />
            <asp:BoundField DataField="quantity" HeaderText="Količina" />
            <asp:BoundField DataField="category" HeaderText="Kategorija" />

            <asp:TemplateField HeaderText="Akcije">
                <ItemTemplate>
                    <asp:LinkButton ID="BtnDelete"
                                    runat="server"
                                    Text="Obriši"
                                    CssClass="btn-delete"
                                    CommandName="delete"
                                    CommandArgument='<%# Eval("id") %>'
                                    OnClientClick="return confirm('Obrisati ovaj proizvod?');" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>

</div>

</asp:Content>
