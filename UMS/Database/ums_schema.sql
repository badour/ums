/* ============================================
   UMS ERP - Database Schema
   SQL Server
   ============================================ */

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'UmsDb')
    CREATE DATABASE UmsDb;
GO

USE UmsDb;
GO

-- Departments
IF OBJECT_ID('dbo.Enrollments', 'U') IS NOT NULL DROP TABLE dbo.Enrollments;
IF OBJECT_ID('dbo.Courses', 'U') IS NOT NULL DROP TABLE dbo.Courses;
IF OBJECT_ID('dbo.Instructors', 'U') IS NOT NULL DROP TABLE dbo.Instructors;
IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL DROP TABLE dbo.Students;
IF OBJECT_ID('dbo.Departments', 'U') IS NOT NULL DROP TABLE dbo.Departments;
GO

CREATE TABLE dbo.Departments
(
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentCode NVARCHAR(20) NOT NULL UNIQUE,
    DepartmentName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2 NULL
);
GO

CREATE TABLE dbo.Students
(
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    RegistrationNumber NVARCHAR(50) NOT NULL UNIQUE,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200) NOT NULL UNIQUE,
    Phone NVARCHAR(30) NULL,
    DateOfBirth DATE NULL,
    Gender NVARCHAR(10) NULL,
    Address NVARCHAR(500) NULL,
    DepartmentId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2 NULL,
    CONSTRAINT FK_Students_Departments
        FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId)
);
GO

CREATE TABLE dbo.Instructors
(
    InstructorId INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeNumber NVARCHAR(50) NOT NULL UNIQUE,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200) NOT NULL UNIQUE,
    Phone NVARCHAR(30) NULL,
    Specialization NVARCHAR(200) NULL,
    DepartmentId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2 NULL,
    CONSTRAINT FK_Instructors_Departments
        FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId)
);
GO

CREATE TABLE dbo.Courses
(
    CourseId INT IDENTITY(1,1) PRIMARY KEY,
    CourseCode NVARCHAR(30) NOT NULL UNIQUE,
    CourseTitle NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    CreditHours INT NOT NULL,
    DepartmentId INT NOT NULL,
    InstructorId INT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2 NULL,
    CONSTRAINT FK_Courses_Departments
        FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId),
    CONSTRAINT FK_Courses_Instructors
        FOREIGN KEY (InstructorId) REFERENCES dbo.Instructors(InstructorId)
);
GO

CREATE TABLE dbo.Enrollments
(
    EnrollmentId INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    Semester NVARCHAR(30) NOT NULL,
    AcademicYear NVARCHAR(20) NOT NULL,
    Grade NVARCHAR(5) NULL,
    EnrollmentDate DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    Status NVARCHAR(20) NOT NULL DEFAULT 'Active',
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    UpdatedAt DATETIME2 NULL,
    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (StudentId) REFERENCES dbo.Students(StudentId),
    CONSTRAINT FK_Enrollments_Courses
        FOREIGN KEY (CourseId) REFERENCES dbo.Courses(CourseId),
    CONSTRAINT UQ_Enrollments UNIQUE (StudentId, CourseId, Semester, AcademicYear)
);
GO

-- Seed Data
INSERT INTO dbo.Departments (DepartmentCode, DepartmentName, Description) VALUES
('CSE', 'Computer Science and Engineering', 'Department of Computer Science, Software Engineering, and Information Technology'),
('BBA', 'Business Administration', 'Department of Business Administration, Finance, and Management'),
('EEE', 'Electrical and Electronic Engineering', 'Department of Electrical, Electronics, and Communication Engineering'),
('CIV', 'Civil Engineering', 'Department of Civil and Structural Engineering'),
('MED', 'Medicine', 'Faculty of Medicine and Health Sciences');
GO

INSERT INTO dbo.Instructors (EmployeeNumber, FirstName, LastName, Email, Phone, Specialization, DepartmentId) VALUES
('EMP1001', 'Amina', 'Rahman', 'amina.rahman@university.edu', '+1-555-0101', 'Artificial Intelligence', 1),
('EMP1002', 'David', 'Khan', 'david.khan@university.edu', '+1-555-0102', 'Marketing', 2),
('EMP1003', 'Sara', 'Noor', 'sara.noor@university.edu', '+1-555-0103', 'Power Systems', 3),
('EMP1004', 'James', 'Wilson', 'james.wilson@university.edu', '+1-555-0104', 'Structural Engineering', 4),
('EMP1005', 'Fatima', 'Ali', 'fatima.ali@university.edu', '+1-555-0105', 'Internal Medicine', 5);
GO

INSERT INTO dbo.Students (RegistrationNumber, FirstName, LastName, Email, Phone, DateOfBirth, Gender, DepartmentId) VALUES
('REG2026001', 'John', 'Miller', 'john.miller@student.edu', '+1-555-1001', '2004-01-12', 'Male', 1),
('REG2026002', 'Nadia', 'Hassan', 'nadia.hassan@student.edu', '+1-555-1002', '2003-05-22', 'Female', 2),
('REG2026003', 'Ethan', 'Lewis', 'ethan.lewis@student.edu', '+1-555-1003', '2004-11-03', 'Male', 3),
('REG2026004', 'Maria', 'Garcia', 'maria.garcia@student.edu', '+1-555-1004', '2003-08-15', 'Female', 4),
('REG2026005', 'Omar', 'Ibrahim', 'omar.ibrahim@student.edu', '+1-555-1005', '2004-03-28', 'Male', 5);
GO

INSERT INTO dbo.Courses (CourseCode, CourseTitle, Description, CreditHours, DepartmentId, InstructorId) VALUES
('CSE101', 'Introduction to Programming', 'Fundamentals of programming using C#', 3, 1, 1),
('CSE201', 'Data Structures', 'Arrays, linked lists, trees, graphs, and algorithms', 3, 1, 1),
('BBA210', 'Principles of Management', 'Introduction to management theories and practices', 3, 2, 2),
('EEE120', 'Circuit Analysis', 'Basic electrical circuits and analysis techniques', 4, 3, 3),
('CIV110', 'Engineering Mechanics', 'Statics and dynamics fundamentals', 3, 4, 4),
('MED101', 'Human Anatomy', 'Introduction to human anatomy and physiology', 4, 5, 5);
GO

INSERT INTO dbo.Enrollments (StudentId, CourseId, Semester, AcademicYear, Grade) VALUES
(1, 1, 'Spring', '2026', 'A'),
(1, 2, 'Spring', '2026', NULL),
(2, 3, 'Spring', '2026', 'B+'),
(3, 4, 'Spring', '2026', NULL),
(4, 5, 'Spring', '2026', 'A-'),
(5, 6, 'Spring', '2026', NULL);
GO
