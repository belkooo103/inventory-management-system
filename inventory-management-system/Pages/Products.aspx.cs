using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace inventory_management_system.Pages
{
    public partial class Products : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = "SELECT id, name FROM categories WHERE is_deleted = 0";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    DdlCategories.DataSource = dt;
                    DdlCategories.DataTextField = "name";
                    DdlCategories.DataValueField = "id";
                    DdlCategories.DataBind();
                }
            }
        }

        private void LoadProducts(string search = "")
        {
            string categoryId = Request.QueryString["categoryId"];

            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = @"
                    SELECT p.id, p.name, p.sku, p.price, p.quantity,
                           c.name AS category
                    FROM products p
                    JOIN categories c ON c.id = p.category_id
                    WHERE p.is_deleted = 0
                      AND (@search = '' OR p.name LIKE CONCAT('%',@search,'%')
                                      OR p.sku  LIKE CONCAT('%',@search,'%'))";

                if (!string.IsNullOrEmpty(categoryId))
                    query += " AND p.category_id = @catId";

                query += " ORDER BY p.created_at DESC";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@search", search);

                    if (!string.IsNullOrEmpty(categoryId))
                        cmd.Parameters.AddWithValue("@catId", categoryId);

                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        ProductsGrid.DataSource = dt;
                        ProductsGrid.DataBind();
                    }
                }
            }
        }

        protected void BtnAddProduct_Click(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = @"
                    INSERT INTO products
                    (name, sku, price, quantity, category_id)
                    VALUES
                    (@name, @sku, @price, @qty, @cat)";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", TxtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@sku", TxtSku.Text.Trim());
                    cmd.Parameters.AddWithValue("@price", decimal.Parse(TxtPrice.Text));
                    cmd.Parameters.AddWithValue("@qty", int.Parse(TxtQuantity.Text));
                    cmd.Parameters.AddWithValue("@cat", DdlCategories.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            TxtName.Text = TxtSku.Text = TxtPrice.Text = TxtQuantity.Text = "";
            LoadProducts(TxtSearch.Text.Trim());
        }

        protected void TxtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadProducts(TxtSearch.Text.Trim());
        }

        protected void ProductsGrid_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                SoftDeleteProduct(id);
                LoadProducts(TxtSearch.Text.Trim());
            }
        }

        private void SoftDeleteProduct(int id)
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = "UPDATE products SET is_deleted = 1 WHERE id = @id";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}