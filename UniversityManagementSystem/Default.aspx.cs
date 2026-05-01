using System;
using System.Web.UI;

public partial class _Default : Page
{
    private readonly UniversityRepository _repository = new UniversityRepository();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            return;
        }

        var metrics = _repository.GetDashboardMetrics();
        lblStudents.Text = metrics.TotalStudents.ToString();
        lblCourses.Text = metrics.TotalCourses.ToString();
        lblEnrollments.Text = metrics.TotalEnrollments.ToString();
    }
}
