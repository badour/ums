using System;
using System.Web.UI;

public partial class AiAssistant : Page
{
    private readonly AiAssistantService _aiService = new AiAssistantService(new UniversityRepository());

    protected void btnAsk_Click(object sender, EventArgs e)
    {
        lblError.Text = string.Empty;
        litAnswer.Text = string.Empty;

        try
        {
            var question = txtQuestion.Text.Trim();
            if (string.IsNullOrWhiteSpace(question))
            {
                lblError.Text = "Please enter a question.";
                return;
            }

            string userName = "Anonymous";
            if (Context != null && Context.User != null && Context.User.Identity != null && Context.User.Identity.IsAuthenticated)
            {
                userName = Context.User.Identity.Name;
            }

            var answer = _aiService.Ask(question, userName);
            litAnswer.Text = Server.HtmlEncode(answer).Replace(Environment.NewLine, "<br />");
            pnlAnswer.Visible = true;
        }
        catch (Exception ex)
        {
            pnlAnswer.Visible = false;
            lblError.Text = "Failed to get AI response: " + Server.HtmlEncode(ex.Message);
        }
    }
}
