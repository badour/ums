<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UMS._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Page Header -->
    <div class="page-header">
        <div>
            <h1>Dashboard</h1>
            <div class="breadcrumb-nav">
                <a href="Default.aspx"><i class="fas fa-home"></i></a>
                <span class="separator">/</span>
                <span>Dashboard</span>
            </div>
        </div>
    </div>

    <!-- Stat Cards -->
    <div class="row g-4 mb-4">
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card stat-card">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="stat-label">Students</div>
                            <div class="stat-value"><asp:Label ID="lblStudents" runat="server" Text="0" /></div>
                        </div>
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card stat-card stat-success">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="stat-label">Courses</div>
                            <div class="stat-value"><asp:Label ID="lblCourses" runat="server" Text="0" /></div>
                        </div>
                        <div class="stat-icon bg-success bg-opacity-10 text-success">
                            <i class="fas fa-book"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card stat-card stat-info">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="stat-label">Enrollments</div>
                            <div class="stat-value"><asp:Label ID="lblEnrollments" runat="server" Text="0" /></div>
                        </div>
                        <div class="stat-icon bg-info bg-opacity-10 text-info">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card stat-card stat-warning">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="stat-label">Departments</div>
                            <div class="stat-value"><asp:Label ID="lblDepartments" runat="server" Text="0" /></div>
                        </div>
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                            <i class="fas fa-building"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card stat-card stat-danger">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="stat-label">Instructors</div>
                            <div class="stat-value"><asp:Label ID="lblInstructors" runat="server" Text="0" /></div>
                        </div>
                        <div class="stat-icon bg-danger bg-opacity-10 text-danger">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card stat-card">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <div class="stat-label">Active</div>
                            <div class="stat-value"><asp:Label ID="lblActive" runat="server" Text="0" /></div>
                        </div>
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="row g-4 mb-4">
        <div class="col-xl-8">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-chart-bar me-2"></i>Enrollment Overview</h5>
                </div>
                <div class="card-body">
                    <canvas id="enrollmentChart" height="300"></canvas>
                </div>
            </div>
        </div>
        <div class="col-xl-4">
            <div class="card">
                <div class="card-header">
                    <h5><i class="fas fa-chart-pie me-2"></i>Students by Department</h5>
                </div>
                <div class="card-body">
                    <canvas id="departmentChart" height="300"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Links -->
    <div class="row g-4">
        <div class="col-md-6 col-lg-3">
            <a href="Students.aspx" class="card text-decoration-none">
                <div class="card-body text-center py-4">
                    <i class="fas fa-user-graduate fa-2x text-primary mb-3"></i>
                    <h6 class="text-primary mb-0">Manage Students</h6>
                </div>
            </a>
        </div>
        <div class="col-md-6 col-lg-3">
            <a href="Courses.aspx" class="card text-decoration-none">
                <div class="card-body text-center py-4">
                    <i class="fas fa-book fa-2x text-success mb-3"></i>
                    <h6 class="text-success mb-0">Manage Courses</h6>
                </div>
            </a>
        </div>
        <div class="col-md-6 col-lg-3">
            <a href="Instructors.aspx" class="card text-decoration-none">
                <div class="card-body text-center py-4">
                    <i class="fas fa-chalkboard-teacher fa-2x text-danger mb-3"></i>
                    <h6 class="text-danger mb-0">Manage Instructors</h6>
                </div>
            </a>
        </div>
        <div class="col-md-6 col-lg-3">
            <a href="Enrollments.aspx" class="card text-decoration-none">
                <div class="card-body text-center py-4">
                    <i class="fas fa-clipboard-list fa-2x text-info mb-3"></i>
                    <h6 class="text-info mb-0">Manage Enrollments</h6>
                </div>
            </a>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptsContent" runat="server">
<script>
    $(document).ready(function () {
        // Enrollment Bar Chart
        var ctxBar = document.getElementById('enrollmentChart').getContext('2d');
        new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: ['CSE', 'BBA', 'EEE', 'CIV', 'MED'],
                datasets: [{
                    label: 'Enrollments',
                    data: [2, 1, 1, 1, 1],
                    backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b'],
                    borderRadius: 6,
                    barThickness: 40
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, ticks: { stepSize: 1 } }
                }
            }
        });

        // Department Doughnut Chart
        var ctxDoughnut = document.getElementById('departmentChart').getContext('2d');
        new Chart(ctxDoughnut, {
            type: 'doughnut',
            data: {
                labels: ['CSE', 'BBA', 'EEE', 'CIV', 'MED'],
                datasets: [{
                    data: [1, 1, 1, 1, 1],
                    backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '65%',
                plugins: { legend: { position: 'bottom' } }
            }
        });
    });
</script>
</asp:Content>
