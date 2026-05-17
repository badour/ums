using System;

public class DashboardMetrics
{
    public int TotalStudents { get; set; }
    public int TotalCourses { get; set; }
    public int TotalEnrollments { get; set; }
    public int TotalDepartments { get; set; }
    public int TotalInstructors { get; set; }
    public int ActiveStudents { get; set; }
}

public class LookupItem
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public class Department
{
    public int DepartmentId { get; set; }
    public string DepartmentCode { get; set; }
    public string DepartmentName { get; set; }
    public string Description { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
    public int StudentCount { get; set; }
    public int CourseCount { get; set; }
    public int InstructorCount { get; set; }
}

public class Student
{
    public int StudentId { get; set; }
    public string RegistrationNumber { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string Gender { get; set; }
    public string Address { get; set; }
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }

    public string FullName
    {
        get { return (FirstName + " " + LastName).Trim(); }
    }
}

public class Instructor
{
    public int InstructorId { get; set; }
    public string EmployeeNumber { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Phone { get; set; }
    public string Specialization { get; set; }
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; }
    public bool IsActive { get; set; }
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
    public string Description { get; set; }
    public int CreditHours { get; set; }
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; }
    public int? InstructorId { get; set; }
    public string InstructorName { get; set; }
    public bool IsActive { get; set; }
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
    public string RegistrationNumber { get; set; }
    public int CourseId { get; set; }
    public string CourseTitle { get; set; }
    public string Semester { get; set; }
    public string AcademicYear { get; set; }
    public string Grade { get; set; }
    public DateTime EnrollmentDate { get; set; }
    public string Status { get; set; }
}
