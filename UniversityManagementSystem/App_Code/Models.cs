using System;

public class DashboardMetrics
{
    public int TotalStudents { get; set; }
    public int TotalCourses { get; set; }
    public int TotalEnrollments { get; set; }
}

public class LookupItem
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public class Student
{
    public int StudentId { get; set; }
    public string StudentNumber { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; }
    public DateTime CreatedAt { get; set; }
    public string FullName
    {
        get { return (FirstName + " " + LastName).Trim(); }
    }
}

public class Course
{
    public int CourseId { get; set; }
    public string CourseCode { get; set; }
    public string CourseTitle { get; set; }
    public int CreditHours { get; set; }
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; }
    public int? InstructorId { get; set; }
    public string InstructorName { get; set; }
    public DateTime CreatedAt { get; set; }
    public string DisplayName
    {
        get { return CourseCode + " - " + CourseTitle; }
    }
}

public class Enrollment
{
    public int EnrollmentId { get; set; }
    public int StudentId { get; set; }
    public string StudentName { get; set; }
    public int CourseId { get; set; }
    public string CourseTitle { get; set; }
    public string Semester { get; set; }
    public string AcademicYear { get; set; }
    public string Grade { get; set; }
    public DateTime EnrollmentDate { get; set; }
}
