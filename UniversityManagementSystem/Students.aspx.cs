using System;
using System.Web.UI;

public partial class Students : Page
{
    private readonly UniversityRepository _repository = new UniversityRepository();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDepartments();
            BindStudents();
        }
    }

    protected void btnAddStudent_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(txtStudentNumber.Text) || string.IsNullOrWhiteSpace(txtFirstName.Text) || string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                lblMessage.Text = "Student number, first name and last name are required.";
                return;
            }

            _repository.AddStudent(new Student
            {
                StudentNumber = txtStudentNumber.Text.Trim(),
                FirstName = txtFirstName.Text.Trim(),
                LastName = txtLastName.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                DepartmentId = int.Parse(ddlDepartment.SelectedValue)
            });

            txtStudentNumber.Text = string.Empty;
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            lblMessage.Text = "Student added successfully.";
            BindStudents();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error adding student: " + ex.Message;
        }
    }

    private void BindDepartments()
    {
        ddlDepartment.DataSource = _repository.GetDepartments();
        ddlDepartment.DataTextField = "Name";
        ddlDepartment.DataValueField = "Id";
        ddlDepartment.DataBind();
    }

    private void BindStudents()
    {
        gvStudents.DataSource = _repository.GetStudents();
        gvStudents.DataBind();
    }
}
