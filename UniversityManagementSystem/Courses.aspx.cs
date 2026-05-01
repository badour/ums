using System;
using System.Web.UI;

public partial class Courses : Page
{
    private readonly UniversityRepository _repository = new UniversityRepository();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDepartments();
            BindInstructors();
            BindCourses();
        }
    }

    protected void btnAddCourse_Click(object sender, EventArgs e)
    {
        int departmentId;
        if (!int.TryParse(ddlDepartments.SelectedValue, out departmentId))
        {
            lblMessage.Text = "Select a valid department.";
            lblMessage.ForeColor = System.Drawing.Color.DarkRed;
            return;
        }

        int credits;
        if (!int.TryParse(txtCredits.Text.Trim(), out credits))
        {
            credits = 3;
        }

        int instructorIdValue;
        int? instructorId = null;
        if (int.TryParse(ddlInstructors.SelectedValue, out instructorIdValue))
        {
            instructorId = instructorIdValue;
        }

        var course = new Course
        {
            CourseCode = txtCode.Text.Trim(),
            CourseTitle = txtTitle.Text.Trim(),
            CreditHours = credits,
            DepartmentId = departmentId,
            InstructorId = instructorId
        };

        if (string.IsNullOrWhiteSpace(course.CourseCode) || string.IsNullOrWhiteSpace(course.CourseTitle))
        {
            lblMessage.Text = "Course code and title are required.";
            lblMessage.ForeColor = System.Drawing.Color.DarkRed;
            return;
        }

        _repository.AddCourse(course);
        lblMessage.Text = "Course added successfully.";
        lblMessage.ForeColor = System.Drawing.Color.DarkGreen;

        txtCode.Text = string.Empty;
        txtTitle.Text = string.Empty;
        txtCredits.Text = "3";
        BindCourses();
    }

    private void BindDepartments()
    {
        ddlDepartments.DataSource = _repository.GetDepartments();
        ddlDepartments.DataTextField = "Name";
        ddlDepartments.DataValueField = "Id";
        ddlDepartments.DataBind();
    }

    private void BindInstructors()
    {
        ddlInstructors.DataSource = _repository.GetInstructors();
        ddlInstructors.DataTextField = "Name";
        ddlInstructors.DataValueField = "Id";
        ddlInstructors.DataBind();

        ddlInstructors.Items.Insert(0, new System.Web.UI.WebControls.ListItem("(Not Assigned)", ""));
    }

    private void BindCourses()
    {
        gvCourses.DataSource = _repository.GetCourses();
        gvCourses.DataBind();
    }
}
