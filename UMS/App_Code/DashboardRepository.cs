using System.Data.SqlClient;

public class DashboardRepository
{
    public DashboardMetrics GetMetrics()
    {
        var metrics = new DashboardMetrics();

        using (var conn = DbHelper.GetConnection())
        {
            conn.Open();
            metrics.TotalStudents = DbHelper.ExecuteScalarInt(conn, "SELECT COUNT(*) FROM dbo.Students");
            metrics.TotalCourses = DbHelper.ExecuteScalarInt(conn, "SELECT COUNT(*) FROM dbo.Courses");
            metrics.TotalEnrollments = DbHelper.ExecuteScalarInt(conn, "SELECT COUNT(*) FROM dbo.Enrollments");
            metrics.TotalDepartments = DbHelper.ExecuteScalarInt(conn, "SELECT COUNT(*) FROM dbo.Departments");
            metrics.TotalInstructors = DbHelper.ExecuteScalarInt(conn, "SELECT COUNT(*) FROM dbo.Instructors");
            metrics.ActiveStudents = DbHelper.ExecuteScalarInt(conn, "SELECT COUNT(*) FROM dbo.Students WHERE IsActive = 1");
        }

        return metrics;
    }
}
