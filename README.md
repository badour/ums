# University Management System (UMS) ERP

A comprehensive university management ERP system built with ASP.NET Web Forms (C#) targeting .NET Framework 4.7.2.

## Technology Stack

- **Backend:** ASP.NET Web Forms (C#) - .NET Framework 4.7.2
- **Frontend:** Bootstrap 5.3.3, Font Awesome 6, custom admin theme
- **Database:** Microsoft SQL Server
- **Libraries:** DataTables, Chart.js, Select2, SweetAlert2, Toastr
- **PDF Reports:** Rotativa (wkhtmltopdf)
- **Styling:** SCSS (compiled to CSS)

## Project Structure

```
UMS.sln                     ← Visual Studio Solution
UMS/                        ← Web Application Project
├── App_Code/               ← C# Models, Repositories, Helpers
├── Database/               ← SQL schema and seed scripts
├── Properties/             ← AssemblyInfo.cs
├── assets/
│   ├── css/                ← Custom theme CSS
│   ├── js/                 ← Custom theme JavaScript
│   ├── fonts/              ← Custom fonts
│   ├── images/             ← Image assets
│   └── lib/                ← Third-party libraries
│       ├── bootstrap/      ← Bootstrap 5 (LTR + RTL)
│       ├── fontawesome/    ← Font Awesome 6
│       ├── datatables/     ← DataTables + jQuery
│       ├── chartjs/        ← Chart.js
│       ├── select2/        ← Select2
│       ├── sweetalert2/    ← SweetAlert2
│       └── toastr/         ← Toastr notifications
├── Site.master             ← Master page (layout)
├── Default.aspx            ← Dashboard
├── Web.config              ← Configuration
└── UMS.csproj              ← Project file
Rotativa/                   ← PDF generation library
scss/                       ← SCSS source files
```

## Getting Started

### Prerequisites

- Visual Studio 2019 or later
- .NET Framework 4.7.2 Developer Pack
- SQL Server 2019 or later

### Setup

1. Open `UMS.sln` in Visual Studio
2. Create the database by running `UMS/Database/ums_schema.sql` in SQL Server Management Studio
3. Update the connection string in `UMS/Web.config` if needed
4. Press F5 to build and run

### Database

Default connection string:
```
Server=.;Database=UmsDb;Trusted_Connection=True;
```

## Features

- **Dashboard** – Overview stats with Chart.js visualizations
- **Departments** – Department management (CRUD)
- **Students** – Student registration and management
- **Instructors** – Faculty management
- **Courses** – Course catalog management
- **Enrollments** – Student enrollment tracking
- **RTL/LTR** – Bilingual support (English/Arabic)
- **Responsive** – Mobile-friendly admin theme with collapsible sidebar

## License

© 2026 University Management System. All rights reserved.
