<%@ Page Title="Categories"
    Language="C#"
    MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Categories.aspx.cs"
    Inherits="inventory_management_system.Pages.Categories" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

<div class="categories-container">
    <div class="categories-cards">

        <div class="categories-header">
            <asp:TextBox ID="TextCategoryName"
                         runat="server"
                         CssClass="search-box"
                         placeholder="Naziv kategorije" />

            <asp:Button ID="ButtonAdd"
                        runat="server"
                        Text="Dodaj"
                        CssClass="btn btn-add"
                        OnClick="ButtonAdd_Click"
                        UseSubmitBehavior="true" />

            <asp:Label ID="LblMsg"
                       runat="server"
                       CssClass="msg"
                       EnableViewState="false" />
        </div>

        <div class="cards-container">
            <asp:Repeater ID="CategoriesRepeater"
                          runat="server"
                          OnItemCommand="CategoriesRepeater_ItemCommand">
                <ItemTemplate>
                    <div class="cards card-wrap">

                        
                        <a class="card-link"
                           href='<%# ResolveUrl("~/Pages/Products.aspx?categoryId=" + Eval("id")) %>'>
                            <div class="link-card-header">
                                <%# Eval("name") %>
                            </div>
                        </a>

                        <asp:LinkButton ID="BtnDelete"
                                        runat="server"
                                        CssClass="btn-delete"
                                        Text="Obriši"
                                        CommandName="delete"
                                        CommandArgument='<%# Eval("id") %>'
                                        OnClientClick="return confirm('Obrisati ovu kategoriju?');" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</div>

</asp:Content>
