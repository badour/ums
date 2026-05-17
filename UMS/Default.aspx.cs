using System;
using System.Web.UI;

namespace UMS
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            var repo = new DashboardRepository();
            var metrics = repo.GetMetrics();

            lblStudents.Text = metrics.TotalStudents.ToString();
            lblCourses.Text = metrics.TotalCourses.ToString();
            lblEnrollments.Text = metrics.TotalEnrollments.ToString();
            lblDepartments.Text = metrics.TotalDepartments.ToString();
            lblInstructors.Text = metrics.TotalInstructors.ToString();
            lblActive.Text = metrics.ActiveStudents.ToString();
        }
    }
}
