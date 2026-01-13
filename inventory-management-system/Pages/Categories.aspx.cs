using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI;

namespace inventory_management_system.Pages
{
    public partial class Categories : Page
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
            LblMsg.Text = "";

            var name = TextCategoryName.Text.Trim();
            if (string.IsNullOrWhiteSpace(name))
            {
                LblMsg.Text = "Unesi naziv.";
                return;
            }

            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    con.Open();

                    // 1) Restore ako postoji obrisana kategorija
                    string restoreQuery = @"
                        UPDATE categories
                        SET is_deleted = 0
                        WHERE name = @name AND is_deleted = 1";

                    using (MySqlCommand restoreCmd = new MySqlCommand(restoreQuery, con))
                    {
                        restoreCmd.Parameters.AddWithValue("@name", name);
                        int restoredRows = restoreCmd.ExecuteNonQuery();

                        if (restoredRows > 0)
                        {
                            TextCategoryName.Text = "";
                            LblMsg.Text = "Vraćena obrisana kategorija.";
                            LoadCategories();
                            return;
                        }
                    }

                    // 2) Insert nova kategorija
                    string insertQuery = "INSERT INTO categories (name, is_deleted) VALUES (@name, 0)";
                    using (MySqlCommand insertCmd = new MySqlCommand(insertQuery, con))
                    {
                        insertCmd.Parameters.AddWithValue("@name", name);
                        insertCmd.ExecuteNonQuery();
                    }
                }

                TextCategoryName.Text = "";
                LblMsg.Text = "Dodano.";
                LoadCategories();
            }
            catch (MySqlException ex)
            {
                if (ex.Number == 1062)
                {
                    LblMsg.Text = "Već postoji kategorija s tim imenom.";
                    return;
                }

                LblMsg.Text = "MySQL greška: " + ex.Message;
            }
            catch (Exception ex)
            {
                LblMsg.Text = "Greška: " + ex.Message;
            }
        }

        protected void CategoriesRepeater_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                try
                {
                    SoftDeleteCategory(id);
                    LblMsg.Text = "Obrisano.";
                    LoadCategories();
                }
                catch (Exception ex)
                {
                    LblMsg.Text = "Greška pri brisanju: " + ex.Message;
                }
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
