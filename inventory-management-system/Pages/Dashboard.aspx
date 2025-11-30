<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="inventory_management_system.Pages.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="products-container">
    <div class="hero-main-info-container">
        <div class="num-of-products">
           <div class="num-of-products-header">Total products: </div>
            <div class="num-of-products-num">300</div>
        </div>
        <div class="sum-of-values"></div>
        <div class="available-products"></div>
        <div class="not-available-products"></div>
    </div>
    <div class="products">
        
        </div>
        </div>
</asp:Content>
