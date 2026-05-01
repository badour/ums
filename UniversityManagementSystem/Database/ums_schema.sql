IF OBJECT_ID('dbo.AiConversationLogs', 'U') IS NOT NULL DROP TABLE dbo.AiConversationLogs;
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
    DepartmentName NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE dbo.Students
(
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    RegistrationNumber NVARCHAR(50) NOT NULL UNIQUE,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200) NOT NULL UNIQUE,
    DateOfBirth DATE NULL,
    DepartmentId INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
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
    DepartmentId INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_Instructors_Departments
        FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments(DepartmentId)
);
GO

CREATE TABLE dbo.Courses
(
    CourseId INT IDENTITY(1,1) PRIMARY KEY,
    CourseCode NVARCHAR(30) NOT NULL UNIQUE,
    CourseTitle NVARCHAR(200) NOT NULL,
    CreditHours INT NOT NULL,
    DepartmentId INT NOT NULL,
    InstructorId INT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
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
    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (StudentId) REFERENCES dbo.Students(StudentId),
    CONSTRAINT FK_Enrollments_Courses
        FOREIGN KEY (CourseId) REFERENCES dbo.Courses(CourseId),
    CONSTRAINT UQ_Enrollments UNIQUE (StudentId, CourseId, Semester, AcademicYear)
);
GO

CREATE TABLE dbo.AiConversationLogs
(
    LogId INT IDENTITY(1,1) PRIMARY KEY,
    UserQuestion NVARCHAR(MAX) NOT NULL,
    AssistantResponse NVARCHAR(MAX) NOT NULL,
    ContextSnapshot NVARCHAR(MAX) NULL,
    Provider NVARCHAR(50) NOT NULL,
    Model NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

INSERT INTO dbo.Departments (DepartmentCode, DepartmentName)
VALUES
('CSE', 'Computer Science and Engineering'),
('BBA', 'Business Administration'),
('EEE', 'Electrical and Electronic Engineering');
GO

INSERT INTO dbo.Instructors (EmployeeNumber, FirstName, LastName, Email, DepartmentId)
VALUES
('EMP1001', 'Amina', 'Rahman', 'amina.rahman@university.edu', 1),
('EMP1002', 'David', 'Khan', 'david.khan@university.edu', 2),
('EMP1003', 'Sara', 'Noor', 'sara.noor@university.edu', 3);
GO

INSERT INTO dbo.Students (RegistrationNumber, FirstName, LastName, Email, DateOfBirth, DepartmentId)
VALUES
('REG2026001', 'John', 'Miller', 'john.miller@student.edu', '2004-01-12', 1),
('REG2026002', 'Nadia', 'Hassan', 'nadia.hassan@student.edu', '2003-05-22', 2),
('REG2026003', 'Ethan', 'Lewis', 'ethan.lewis@student.edu', '2004-11-03', 3);
GO

INSERT INTO dbo.Courses (CourseCode, CourseTitle, CreditHours, DepartmentId, InstructorId)
VALUES
('CSE101', 'Introduction to Programming', 3, 1, 1),
('BBA210', 'Principles of Management', 3, 2, 2),
('EEE120', 'Circuit Analysis', 4, 3, 3);
GO

INSERT INTO dbo.Enrollments (StudentId, CourseId, Semester, AcademicYear, Grade)
VALUES
(1, 1, 'Spring', '2026', NULL),
(2, 2, 'Spring', '2026', NULL),
(3, 3, 'Spring', '2026', NULL);
GO
