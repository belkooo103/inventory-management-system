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
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadLatestProducts();
            }
        }

       
        private void LoadStats()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                LblCategories.Text = ExecuteScalar(
                    con,
                    "SELECT COUNT(*) FROM categories WHERE is_deleted = 0"
                );

                LblProducts.Text = ExecuteScalar(
                    con,
                    "SELECT COUNT(*) FROM products WHERE is_deleted = 0"
                );

                LblSuppliers.Text = ExecuteScalar(
                    con,
                    "SELECT COUNT(*) FROM suppliers"
                );

                LblStock.Text = ExecuteScalar(
                    con,
                    "SELECT IFNULL(SUM(quantity),0) FROM products WHERE is_deleted = 0"
                );
            }
        }

        
        private void LoadLatestProducts()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = @"
                    SELECT name, sku, quantity, created_at
                    FROM products
                    WHERE is_deleted = 0
                    ORDER BY created_at DESC
                    LIMIT 5";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    LatestProductsGrid.DataSource = dt;
                    LatestProductsGrid.DataBind();
                }
            }
        }

      
        private string ExecuteScalar(MySqlConnection con, string query)
        {
            using (MySqlCommand cmd = new MySqlCommand(query, con))
            {
                object result = cmd.ExecuteScalar();
                return result != null ? result.ToString() : "0";
            }
        }
    }
}