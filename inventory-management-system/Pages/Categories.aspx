<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="inventory_management_system.Pages.Categories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="categories-container">
        <div class="categories-cards">
         <div class="categories-header">
             <input id="TextSearchCategory" type="text" placeholder="Pretrazite kategoriju:"/>
             <asp:Button ID="ButtonAdd" runat="server" Text="Dodaj" />
             <asp:Button ID="ButtonRemove" runat="server" Text="Obrisi" />
         </div>
        <div class="cards-container">
            
            <asp:HyperLink ID="HyperLink1" CssClass="cards" runat="server">
                <div class="link-card-header">Graficke kartice</div>
            </asp:HyperLink>
            <asp:HyperLink ID="HyperLink2" CssClass="cards" runat="server">
                  <div class="link-card-header">Stolice</div>
            </asp:HyperLink>
            <asp:HyperLink ID="HyperLink3" CssClass="cards" runat="server">
                <div class="link-card-header">Mobilni uredjaji</div>
            </asp:HyperLink>
             <asp:HyperLink ID="HyperLink4" CssClass="cards" runat="server">
                 <div class="link-card-header">Maticne ploce</div>
             </asp:HyperLink>

            
        </div>
            </div>
   
    </div>
</asp:Content>
