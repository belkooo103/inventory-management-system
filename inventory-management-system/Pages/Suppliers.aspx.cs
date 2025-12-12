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
    public partial class Suppliers : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSuppliers();
            }
        }

        private void LoadSuppliers()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = @"
                    SELECT name, email, phone, address, created_at
                    FROM suppliers
                    ORDER BY created_at DESC";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    SuppliersGrid.DataSource = dt;
                    SuppliersGrid.DataBind();
                }
            }
        }
    }
}