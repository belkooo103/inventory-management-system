    using MySql.Data.MySqlClient;
    using System;
    using System.Configuration;
    using System.Net.Mail;
    using System.Web.UI;

namespace inventory_management_system.Pages
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
        }
        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                string cs = ConfigurationManager
                    .ConnectionStrings["MyConnection"].ConnectionString;

                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    con.Open();

                    string sql = @"
                INSERT INTO contact_messages
                (full_name, email, subject, message)
                VALUES
                (@name, @email, @subject, @message)";

                    using (MySqlCommand cmd = new MySqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@name", nameTextBox.Text.Trim());
                        cmd.Parameters.AddWithValue("@email", emailTextBox.Text.Trim());
                        cmd.Parameters.AddWithValue("@subject", messageHeaderTextBox.Text.Trim());
                        cmd.Parameters.AddWithValue("@message", messageTextArea.Text.Trim());

                        cmd.ExecuteNonQuery();
                    }
                }

                sendMessage.InnerText = "✅ Poruka je uspješno poslata!";
                sendMessage.Attributes["style"] = "color: green;";

                nameTextBox.Text = "";
                emailTextBox.Text = "";
                messageHeaderTextBox.Text = "";
                messageTextArea.Text = "";
            }
            catch (Exception ex)
            {
                sendMessage.InnerText = "❌ Greška: " + ex.Message;
                sendMessage.Attributes["style"] = "color: red;";
            }
        }


    }
}
