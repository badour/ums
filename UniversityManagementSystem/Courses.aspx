<%@ Page Title="Courses" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Courses.aspx.cs" Inherits="Courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Courses</h2>
    <asp:Label ID="lblMessage" runat="server" />
    <div class="card">
        <h3>Add New Course</h3>
        <div class="form-row">
            <label>Code</label><br />
            <asp:TextBox ID="txtCode" runat="server" />
        </div>
        <div class="form-row">
            <label>Title</label><br />
            <asp:TextBox ID="txtTitle" runat="server" />
        </div>
        <div class="form-row">
            <label>Credit Hours</label><br />
            <asp:TextBox ID="txtCredits" runat="server" Text="3" />
        </div>
        <div class="form-row">
            <label>Department</label><br />
            <asp:DropDownList ID="ddlDepartments" runat="server" />
        </div>
        <div class="form-row">
            <label>Instructor (optional)</label><br />
            <asp:DropDownList ID="ddlInstructors" runat="server" />
        </div>
        <asp:Button ID="btnAddCourse" runat="server" CssClass="btn" Text="Add Course" OnClick="btnAddCourse_Click" />
    </div>

    <div class="card">
        <h3>All Courses</h3>
        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="CourseId" HeaderText="ID" />
                <asp:BoundField DataField="CourseCode" HeaderText="Course Code" />
                <asp:BoundField DataField="CourseTitle" HeaderText="Title" />
                <asp:BoundField DataField="CreditHours" HeaderText="Credit Hours" />
                <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                <asp:BoundField DataField="InstructorName" HeaderText="Instructor" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
