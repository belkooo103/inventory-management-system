<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="inventory_management_system.Pages.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

    
    <h2 class="dashboard-title">Dashboard</h2>

    
    <div class="dashboard-cards">

        <div class="card">
            <div class="card-title">Kategorije</div>
            <div class="card-value">
                <asp:Label ID="LblCategories" runat="server" />
            </div>
        </div>

        <div class="card">
            <div class="card-title">Proizvodi</div>
            <div class="card-value">
                <asp:Label ID="LblProducts" runat="server" />
            </div>
        </div>

        <div class="card">
            <div class="card-title">Dobavljači</div>
            <div class="card-value">
                <asp:Label ID="LblSuppliers" runat="server" />
            </div>
        </div>

        <div class="card">
            <div class="card-title">Ukupna količina</div>
            <div class="card-value">
                <asp:Label ID="LblStock" runat="server" />
            </div>
        </div>

    </div>

   
    <h3 class="dashboard-subtitle">Zadnji dodani proizvodi</h3>

    <div class="dashboard-table">

        <asp:GridView ID="LatestProductsGrid"
                      runat="server"
                      CssClass="grid"
                      AutoGenerateColumns="false"
                      EmptyDataText="Nema proizvoda za prikaz.">

            <Columns>
                <asp:BoundField DataField="name" HeaderText="Naziv" />
                <asp:BoundField DataField="sku" HeaderText="SKU" />
                <asp:BoundField DataField="quantity" HeaderText="Količina" />
                <asp:BoundField DataField="created_at"
                                HeaderText="Dodano"
                                DataFormatString="{0:dd.MM.yyyy HH:mm}" />
            </Columns>

        </asp:GridView>

    </div>

</asp:Content>