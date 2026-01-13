using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Web.UI;

namespace inventory_management_system.Pages
{
    public partial class Products : Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
                BtnDeleteSelected.Enabled = false;
            }
        }

        private void LoadCategories()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = "SELECT id, name FROM categories WHERE is_deleted = 0 ORDER BY created_at DESC";

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

            // nakon rebind-a nema selekcije
            ProductsGrid.SelectedIndex = -1;
            BtnDeleteSelected.Enabled = false;
        }

        protected void BtnAddProduct_Click(object sender, EventArgs e)
        {
            LblMsg.Text = "";

            var name = TxtName.Text.Trim();
            var sku = TxtSku.Text.Trim();

            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(sku))
            {
                LblMsg.Text = "Unesi naziv i SKU.";
                return;
            }

            if (!decimal.TryParse(TxtPrice.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out decimal price) &&
                !decimal.TryParse(TxtPrice.Text.Trim(), NumberStyles.Any, CultureInfo.CurrentCulture, out price))
            {
                LblMsg.Text = "Cijena nije ispravna.";
                return;
            }

            if (!int.TryParse(TxtQuantity.Text.Trim(), out int qty))
            {
                LblMsg.Text = "Količina nije ispravna.";
                return;
            }

            var catId = DdlCategories.SelectedValue;

            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    con.Open();

                    // Restore ako postoji obrisan sa istim SKU
                    string restoreQuery = @"
                        UPDATE products
                        SET is_deleted = 0,
                            name = @name,
                            price = @price,
                            quantity = @qty,
                            category_id = @cat
                        WHERE sku = @sku AND is_deleted = 1";

                    using (MySqlCommand restoreCmd = new MySqlCommand(restoreQuery, con))
                    {
                        restoreCmd.Parameters.AddWithValue("@name", name);
                        restoreCmd.Parameters.AddWithValue("@sku", sku);
                        restoreCmd.Parameters.AddWithValue("@price", price);
                        restoreCmd.Parameters.AddWithValue("@qty", qty);
                        restoreCmd.Parameters.AddWithValue("@cat", catId);

                        int restored = restoreCmd.ExecuteNonQuery();
                        if (restored > 0)
                        {
                            ClearInputs();
                            LblMsg.Text = "Vraćen obrisan proizvod (restore).";
                            LoadProducts(TxtSearch.Text.Trim());
                            return;
                        }
                    }

                    // Insert nova stavka
                    string insertQuery = @"
                        INSERT INTO products (name, sku, price, quantity, category_id, is_deleted)
                        VALUES (@name, @sku, @price, @qty, @cat, 0)";

                    using (MySqlCommand cmd = new MySqlCommand(insertQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@sku", sku);
                        cmd.Parameters.AddWithValue("@price", price);
                        cmd.Parameters.AddWithValue("@qty", qty);
                        cmd.Parameters.AddWithValue("@cat", catId);
                        cmd.ExecuteNonQuery();
                    }
                }

                ClearInputs();
                LblMsg.Text = "Dodano.";
                LoadProducts(TxtSearch.Text.Trim());
            }
            catch (MySqlException ex)
            {
                if (ex.Number == 1062)
                {
                    LblMsg.Text = "Već postoji proizvod sa tim SKU.";
                    return;
                }

                LblMsg.Text = "MySQL greška: " + ex.Message;
            }
            catch (Exception ex)
            {
                LblMsg.Text = "Greška: " + ex.Message;
            }
        }

        protected void TxtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadProducts(TxtSearch.Text.Trim());
        }

        protected void ProductsGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Omogući brisanje tek kad je nešto odabrano
            BtnDeleteSelected.Enabled = (ProductsGrid.SelectedIndex >= 0);
        }

        protected void BtnDeleteSelected_Click(object sender, EventArgs e)
        {
            LblMsg.Text = "";

            if (ProductsGrid.SelectedIndex < 0)
            {
                LblMsg.Text = "Odaberi proizvod u tabeli.";
                BtnDeleteSelected.Enabled = false;
                return;
            }

            int id = Convert.ToInt32(ProductsGrid.DataKeys[ProductsGrid.SelectedIndex].Value);

            try
            {
                SoftDeleteProduct(id);
                LblMsg.Text = "Obrisano.";
                LoadProducts(TxtSearch.Text.Trim());
            }
            catch (Exception ex)
            {
                LblMsg.Text = "Greška pri brisanju: " + ex.Message;
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

        private void ClearInputs()
        {
            TxtName.Text = "";
            TxtSku.Text = "";
            TxtPrice.Text = "";
            TxtQuantity.Text = "";
        }

    }
}
