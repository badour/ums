<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Dashboard</h2>
    <div class="card">
        <h3>System Overview</h3>
        <p><strong>Total Students:</strong> <asp:Label ID="lblStudents" runat="server" /></p>
        <p><strong>Total Courses:</strong> <asp:Label ID="lblCourses" runat="server" /></p>
        <p><strong>Total Enrollments:</strong> <asp:Label ID="lblEnrollments" runat="server" /></p>
    </div>
</asp:Content>
