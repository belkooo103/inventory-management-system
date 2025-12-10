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
            if (nameTextBox.Text == "" || emailTextBox.Text == "" || messageHeaderTextBox.Text == "" || messageTextArea.Text == "")
            {
                sendMessage.InnerText = "Molimo popunite polja!";
            }
            else
            {
                nameTextBox.Text = "";
                emailTextBox.Text = "";
                messageHeaderTextBox.Text = "";
                messageTextArea.Text = "";
                sendMessage.InnerText = "Poruka uspješno poslana!";
            }
        }

    }
}
