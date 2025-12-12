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
    public partial class SearchResults : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadResults();
            }
        }

        private void LoadResults()
        {
            string q = Request.QueryString["q"];

            if (string.IsNullOrWhiteSpace(q))
                return;

            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = @"
                    SELECT p.name, p.sku, p.price, p.quantity,
                           c.name AS category
                    FROM products p
                    JOIN categories c ON c.id = p.category_id
                    WHERE p.is_deleted = 0
                      AND (p.name LIKE CONCAT('%',@q,'%')
                           OR p.sku LIKE CONCAT('%',@q,'%'))
                    ORDER BY p.name";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@q", q);

                    using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        SearchGrid.DataSource = dt;
                        SearchGrid.DataBind();
                    }
                }
            }
        }
    }
}