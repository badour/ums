using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

public class UniversityRepository
{
    private readonly string _connectionString;

    public UniversityRepository()
    {
        _connectionString = ConfigurationManager.ConnectionStrings["UmsDb"].ConnectionString;
    }

    public DashboardMetrics GetDashboardMetrics()
    {
        var metrics = new DashboardMetrics();

        using (var connection = new SqlConnection(_connectionString))
        {
            connection.Open();
            metrics.TotalStudents = ExecuteScalarInt(connection, "SELECT COUNT(*) FROM dbo.Students;");
            metrics.TotalCourses = ExecuteScalarInt(connection, "SELECT COUNT(*) FROM dbo.Courses;");
            metrics.TotalEnrollments = ExecuteScalarInt(connection, "SELECT COUNT(*) FROM dbo.Enrollments;");
        }

        return metrics;
    }

    public List<Student> GetStudents()
    {
        const string sql = @"
SELECT s.StudentId, s.RegistrationNumber, s.FirstName, s.LastName, s.Email, s.DepartmentId, s.CreatedAt, d.DepartmentName
FROM dbo.Students s
INNER JOIN dbo.Departments d ON d.DepartmentId = s.DepartmentId
ORDER BY s.StudentId DESC;";

        var students = new List<Student>();

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            connection.Open();
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    students.Add(new Student
                    {
                        StudentId = reader.GetInt32(0),
                        StudentNumber = reader.GetString(1),
                        FirstName = reader.GetString(2),
                        LastName = reader.GetString(3),
                        Email = reader.GetString(4),
                        DepartmentId = reader.GetInt32(5),
                        CreatedAt = reader.GetDateTime(6),
                        DepartmentName = reader.GetString(7)
                    });
                }
            }
        }

        return students;
    }

    public void AddStudent(Student student)
    {
        const string sql = @"
INSERT INTO dbo.Students (RegistrationNumber, FirstName, LastName, Email, DepartmentId)
VALUES (@RegistrationNumber, @FirstName, @LastName, @Email, @DepartmentId);";

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            command.Parameters.AddWithValue("@RegistrationNumber", student.StudentNumber);
            command.Parameters.AddWithValue("@FirstName", student.FirstName);
            command.Parameters.AddWithValue("@LastName", student.LastName);
            command.Parameters.AddWithValue("@Email", student.Email);
            command.Parameters.AddWithValue("@DepartmentId", student.DepartmentId);

            connection.Open();
            command.ExecuteNonQuery();
        }
    }

    public List<Course> GetCourses()
    {
        const string sql = @"
SELECT c.CourseId, c.CourseCode, c.CourseTitle, c.CreditHours, c.DepartmentId, c.InstructorId, c.CreatedAt,
       d.DepartmentName, i.FirstName + ' ' + i.LastName AS InstructorName
FROM dbo.Courses c
INNER JOIN dbo.Departments d ON d.DepartmentId = c.DepartmentId
LEFT JOIN dbo.Instructors i ON i.InstructorId = c.InstructorId
ORDER BY c.CourseId DESC;";

        var courses = new List<Course>();

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            connection.Open();
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    courses.Add(new Course
                    {
                        CourseId = reader.GetInt32(0),
                        CourseCode = reader.GetString(1),
                        CourseTitle = reader.GetString(2),
                        CreditHours = reader.GetInt32(3),
                        DepartmentId = reader.GetInt32(4),
                        InstructorId = reader.IsDBNull(5) ? (int?)null : reader.GetInt32(5),
                        CreatedAt = reader.GetDateTime(6),
                        DepartmentName = reader.GetString(7),
                        InstructorName = reader.IsDBNull(8) ? "(Not Assigned)" : reader.GetString(8)
                    });
                }
            }
        }

        return courses;
    }

    public void AddCourse(Course course)
    {
        const string sql = @"
INSERT INTO dbo.Courses (CourseCode, CourseTitle, CreditHours, DepartmentId, InstructorId)
VALUES (@CourseCode, @CourseTitle, @CreditHours, @DepartmentId, @InstructorId);";

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            command.Parameters.AddWithValue("@CourseCode", course.CourseCode);
            command.Parameters.AddWithValue("@CourseTitle", course.CourseTitle);
            command.Parameters.AddWithValue("@CreditHours", course.CreditHours);
            command.Parameters.AddWithValue("@DepartmentId", course.DepartmentId);
            command.Parameters.AddWithValue("@InstructorId", (object)course.InstructorId ?? DBNull.Value);

            connection.Open();
            command.ExecuteNonQuery();
        }
    }

    public List<Enrollment> GetEnrollments()
    {
        const string sql = @"
SELECT e.EnrollmentId, e.StudentId, e.CourseId, e.Semester, e.AcademicYear, e.Grade, e.EnrollmentDate,
       s.FirstName + ' ' + s.LastName AS StudentName,
       c.CourseCode + ' - ' + c.CourseTitle AS CourseTitle
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON s.StudentId = e.StudentId
INNER JOIN dbo.Courses c ON c.CourseId = e.CourseId
ORDER BY e.EnrollmentId DESC;";

        var enrollments = new List<Enrollment>();

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            connection.Open();
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    enrollments.Add(new Enrollment
                    {
                        EnrollmentId = reader.GetInt32(0),
                        StudentId = reader.GetInt32(1),
                        CourseId = reader.GetInt32(2),
                        Semester = reader.GetString(3),
                        AcademicYear = reader.GetString(4),
                        Grade = reader.IsDBNull(5) ? null : reader.GetString(5),
                        EnrollmentDate = reader.GetDateTime(6),
                        StudentName = reader.GetString(7),
                        CourseTitle = reader.GetString(8)
                    });
                }
            }
        }

        return enrollments;
    }

    public void AddEnrollment(Enrollment enrollment)
    {
        const string sql = @"
INSERT INTO dbo.Enrollments (StudentId, CourseId, Semester, AcademicYear, Grade, EnrollmentDate)
VALUES (@StudentId, @CourseId, @Semester, @AcademicYear, @Grade, @EnrollmentDate);";

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            command.Parameters.AddWithValue("@StudentId", enrollment.StudentId);
            command.Parameters.AddWithValue("@CourseId", enrollment.CourseId);
            command.Parameters.AddWithValue("@Semester", enrollment.Semester);
            command.Parameters.AddWithValue("@AcademicYear", enrollment.AcademicYear);
            command.Parameters.AddWithValue("@Grade", (object)enrollment.Grade ?? DBNull.Value);
            command.Parameters.AddWithValue("@EnrollmentDate", enrollment.EnrollmentDate);

            connection.Open();
            command.ExecuteNonQuery();
        }
    }

    public List<LookupItem> GetDepartments()
    {
        return GetLookup("SELECT DepartmentId AS Id, DepartmentName AS Name FROM dbo.Departments ORDER BY DepartmentName;");
    }

    public List<LookupItem> GetInstructors()
    {
        const string sql = "SELECT InstructorId AS Id, FirstName + ' ' + LastName AS Name FROM dbo.Instructors ORDER BY Name;";
        return GetLookup(sql);
    }

    public List<LookupItem> GetStudentsLookup()
    {
        const string sql = "SELECT StudentId AS Id, FirstName + ' ' + LastName AS Name FROM dbo.Students ORDER BY FirstName, LastName;";
        return GetLookup(sql);
    }

    public List<LookupItem> GetCoursesLookup()
    {
        const string sql = "SELECT CourseId AS Id, CourseCode + ' - ' + CourseTitle AS Name FROM dbo.Courses ORDER BY CourseCode;";
        return GetLookup(sql);
    }

    public List<Student> GetAllStudents()
    {
        return GetStudents();
    }

    public List<Course> GetAllCourses()
    {
        return GetCourses();
    }

    public List<Enrollment> GetAllEnrollments()
    {
        return GetEnrollments();
    }

    public List<Enrollment> GetEnrollmentViews()
    {
        return GetEnrollments();
    }

    public void InsertAiConversationLog(string askedBy, string userQuestion, string aiResponse, string providerName)
    {
        const string sql = @"
INSERT INTO dbo.AiConversationLogs (UserQuestion, AssistantResponse, ContextSnapshot, Provider, Model)
VALUES (@UserQuestion, @AssistantResponse, @ContextSnapshot, @Provider, @Model);";

        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            command.Parameters.AddWithValue("@UserQuestion", userQuestion);
            command.Parameters.AddWithValue("@AssistantResponse", aiResponse);
            command.Parameters.AddWithValue("@ContextSnapshot", askedBy);
            command.Parameters.AddWithValue("@Provider", providerName);
            command.Parameters.AddWithValue("@Model", string.Empty);
            connection.Open();
            command.ExecuteNonQuery();
        }
    }

    private static int ExecuteScalarInt(SqlConnection connection, string sql)
    {
        using (var command = new SqlCommand(sql, connection))
        {
            return Convert.ToInt32(command.ExecuteScalar());
        }
    }

    private List<LookupItem> GetLookup(string sql)
    {
        var items = new List<LookupItem>();
        using (var connection = new SqlConnection(_connectionString))
        using (var command = new SqlCommand(sql, connection))
        {
            connection.Open();
            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    items.Add(new LookupItem
                    {
                        Id = reader.GetInt32(0),
                        Name = reader.GetString(1)
                    });
                }
            }
        }

        return items;
    }
}
