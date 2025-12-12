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
    public partial class Categories : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCategories();
        }

        private void LoadCategories()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = @"
                    SELECT id, name
                    FROM categories
                    WHERE is_deleted = 0
                    ORDER BY created_at DESC";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    CategoriesRepeater.DataSource = dt;
                    CategoriesRepeater.DataBind();
                }
            }
        }

        protected void ButtonAdd_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TextCategoryName.Text))
                return;

            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = "INSERT INTO categories (name) VALUES (@name)";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", TextCategoryName.Text.Trim());
                    con.Open();

                    try { cmd.ExecuteNonQuery(); }
                    catch (MySqlException ex)
                    {
                        if (ex.Number != 1062) throw;
                    }
                }
            }

            TextCategoryName.Text = "";
            LoadCategories();
        }

        protected void CategoriesRepeater_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                SoftDeleteCategory(id);
                LoadCategories();
            }
        }

        private void SoftDeleteCategory(int id)
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                string query = "UPDATE categories SET is_deleted = 1 WHERE id = @id";

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