using System;
using System.Web.UI;

public partial class Enrollments : Page
{
    private readonly UniversityRepository _repository = new UniversityRepository();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindStudents();
            BindCourses();
            BindEnrollments();
        }
    }

    protected void btnAddEnrollment_Click(object sender, EventArgs e)
    {
        int studentId;
        int courseId;

        if (!int.TryParse(ddlStudents.SelectedValue, out studentId) || !int.TryParse(ddlCourses.SelectedValue, out courseId))
        {
            lblMessage.Text = "Please select valid student and course.";
            return;
        }

        var semester = string.IsNullOrWhiteSpace(txtSemester.Text) ? "Spring" : txtSemester.Text.Trim();
        var academicYear = DateTime.UtcNow.Year.ToString();

        try
        {
            _repository.AddEnrollment(new Enrollment
            {
                StudentId = studentId,
                CourseId = courseId,
                Semester = semester,
                AcademicYear = academicYear,
                Grade = string.IsNullOrWhiteSpace(txtGrade.Text) ? null : txtGrade.Text.Trim(),
                EnrollmentDate = DateTime.UtcNow.Date
            });

            lblMessage.Text = "Enrollment added successfully.";
            txtGrade.Text = string.Empty;
            BindEnrollments();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error adding enrollment: " + ex.Message;
        }
    }

    private void BindStudents()
    {
        ddlStudents.DataSource = _repository.GetStudentsLookup();
        ddlStudents.DataTextField = "Name";
        ddlStudents.DataValueField = "Id";
        ddlStudents.DataBind();
    }

    private void BindCourses()
    {
        ddlCourses.DataSource = _repository.GetCoursesLookup();
        ddlCourses.DataTextField = "Name";
        ddlCourses.DataValueField = "Id";
        ddlCourses.DataBind();
    }

    private void BindEnrollments()
    {
        gvEnrollments.DataSource = _repository.GetEnrollments();
        gvEnrollments.DataBind();
    }
}
