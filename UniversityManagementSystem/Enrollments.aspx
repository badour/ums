<%@ Page Title="Enrollments" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Enrollments.aspx.cs" Inherits="Enrollments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Enrollments</h2>

    <div class="card">
        <h3>Add Enrollment</h3>
        <div class="form-row">
            <label>Student</label>
            <asp:DropDownList ID="ddlStudents" runat="server" />
        </div>
        <div class="form-row">
            <label>Course</label>
            <asp:DropDownList ID="ddlCourses" runat="server" />
        </div>
        <div class="form-row">
            <label>Semester</label>
            <asp:TextBox ID="txtSemester" runat="server" Text="Spring" />
        </div>
        <div class="form-row">
            <label>Grade (Optional)</label>
            <asp:TextBox ID="txtGrade" runat="server" />
        </div>
        <div class="form-row">
            <asp:Button ID="btnAddEnrollment" runat="server" Text="Add Enrollment" CssClass="btn" OnClick="btnAddEnrollment_Click" />
        </div>
        <asp:Label ID="lblMessage" runat="server" />
    </div>

    <div class="card">
        <h3>All Enrollments</h3>
        <asp:GridView ID="gvEnrollments" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="EnrollmentId" HeaderText="ID" />
                <asp:BoundField DataField="StudentName" HeaderText="Student" />
                <asp:BoundField DataField="CourseTitle" HeaderText="Course" />
                <asp:BoundField DataField="Semester" HeaderText="Semester" />
                <asp:BoundField DataField="AcademicYear" HeaderText="Academic Year" />
                <asp:BoundField DataField="Grade" HeaderText="Grade" />
                <asp:BoundField DataField="EnrollmentDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
