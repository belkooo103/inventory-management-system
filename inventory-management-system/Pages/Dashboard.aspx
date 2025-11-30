<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="inventory_management_system.Pages.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="products-container">
    <div class="hero-main-info-container">
        <div class="num-of-products">
           <div class="num-of-products-header">Total Products: </div>
            <div class="num-of-products-num">300</div>
        </div>
        <div class="sum-of-values">
            <div class="sum-of-values-header">Total Value: </div>
            <div class="sum-of-values-num">$153.400<span class="decimal-pointer-after">,00</span></div>
        </div>
        <div class="available-products">
            <div class="available-products-header">• Available</div>
            <div class="available-products-num">200</div>
        </div>
        <div class="not-available-products">
            <div class="not-available-products-header">• Not Available</div>
            <div class="available-products-num">100</div>
        </div>
    </div>
    <div class="products">
        <!-- HEADER -->
            <div class="products-header">
                <div class="products-name-container">
                <asp:CheckBox ID="CheckBoxProductName" class="checkbox" runat="server" />
                    <div class="products-name">Product Name</div>
            </div>
                    <div class="products-categories-container">
                    <div class="products-name">Category </div>
                    </div>
                <div class="products-status-container">
                    <div class="products-name">Status </div>
                    </div>
                 <div class="products-quantity-container">
     <div class="products-name">Quantity </div>
     </div>
                 <div class="products-price-container">
     <div class="products-name">Price / Item </div>
     </div>
                </div>
              <!-- ITEMS -->
        <div class="products-content">
            <div class="product-item">
                <div class="product-item-name">
                    <asp:CheckBox ID="CheckBox1" class="checkbox" runat="server" />
                    <div>Sport jacket</div>
                </div>
                <div class="product-item-category">Sports</div>
                <div class="product-item-status">
                    <div class="available">• Available</div>
                    </div>
                <div class="product-item-quantity">10</div>
                <div class="product-item-price">$20</div>
            </div>

             <div class="product-item">
     <div class="product-item-name">
         <asp:CheckBox ID="CheckBox2" class="checkbox" runat="server" />
         <div>Cargo pants</div>
     </div>
     <div class="product-item-category">Military</div>
     <div class="product-item-status">
         <div class="not-available">• Not Available</div>
         </div>
     <div class="product-item-quantity">0</div>
     <div class="product-item-price">$50</div>
 </div>

            <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox3" class="checkbox" runat="server" />
        <div>Shoes</div>
    </div>
    <div class="product-item-category">RichMan</div>
    <div class="product-item-status">
        <div class="not-available">• Not Available</div>
        </div>
    <div class="product-item-quantity">0</div>
    <div class="product-item-price">$150</div>
</div>

     <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox4" class="checkbox" runat="server" />
        <div>Gucci belt</div>
    </div>
    <div class="product-item-category">RichMan</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$1150</div>
</div>
     <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox5" class="checkbox" runat="server" />
        <div>Rolex Daytona</div>
    </div>
    <div class="product-item-category">Watches</div>
    <div class="product-item-status">
        <div class="not-available">•Not Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$12150</div>
</div>
                 <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox6" class="checkbox" runat="server" />
        <div>Lois Vuitton</div>
    </div>
    <div class="product-item-category">Sun Glasses</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$12150</div>
</div>
     <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox7" class="checkbox" runat="server" />
        <div>Lois Vuitton</div>
    </div>
    <div class="product-item-category">Perfume</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">12</div>
    <div class="product-item-price">$12150</div>
</div>
     <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox8" class="checkbox" runat="server" />
        <div>Lattaffa</div>
    </div>
    <div class="product-item-category">Perfume</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">10</div>
    <div class="product-item-price">$69</div>
</div>
      <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox9" class="checkbox" runat="server" />
        <div>Parfums de Marly Layton</div>
    </div>
    <div class="product-item-category">Perfume</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$600</div>
</div>
                             <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox10" class="checkbox" runat="server" />
        <div>Useless shirt</div>
    </div>
    <div class="product-item-category">Shirt</div>
    <div class="product-item-status">
        <div class="not-available">•Not Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$30</div>
</div>
                             <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox11" class="checkbox" runat="server" />
        <div>Razer Blackshark</div>
    </div>
    <div class="product-item-category">Headphones</div>
    <div class="product-item-status">
        <div class="not-available">•Not Available</div>
        </div>
    <div class="product-item-quantity">12</div>
    <div class="product-item-price">$30</div>
</div>
                             <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox12" class="checkbox" runat="server" />
        <div>Lois Vuitton</div>
    </div>
    <div class="product-item-category">Sun Glasses</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$12150</div>
</div>
                             <div class="product-item">
    <div class="product-item-name">
        <asp:CheckBox ID="CheckBox13" class="checkbox" runat="server" />
        <div>Lois Vuitton</div>
    </div>
    <div class="product-item-category">Sun Glasses</div>
    <div class="product-item-status">
        <div class="available">•Available</div>
        </div>
    <div class="product-item-quantity">1</div>
    <div class="product-item-price">$12150</div>
</div>
        </div>
        </div>
       </div>
</asp:Content>
