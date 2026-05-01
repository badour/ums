<%@ Page Title="Students" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Students.aspx.cs" Inherits="Students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Students</h2>

    <div class="card">
        <h3>Add Student</h3>
        <div>
            <label>Student Number</label><br />
            <asp:TextBox ID="txtStudentNumber" runat="server" />
        </div>
        <div>
            <label>First Name</label><br />
            <asp:TextBox ID="txtFirstName" runat="server" />
        </div>
        <div>
            <label>Last Name</label><br />
            <asp:TextBox ID="txtLastName" runat="server" />
        </div>
        <div>
            <label>Email</label><br />
            <asp:TextBox ID="txtEmail" runat="server" />
        </div>
        <div>
            <label>Department</label><br />
            <asp:DropDownList ID="ddlDepartment" runat="server" />
        </div>
        <div style="margin-top:12px;">
            <asp:Button ID="btnAddStudent" runat="server" Text="Add Student" OnClick="btnAddStudent_Click" />
        </div>
        <div style="margin-top:10px;">
            <asp:Label ID="lblStudentMessage" runat="server" />
        </div>
    </div>

    <div class="card">
        <h3>Student List</h3>
        <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="StudentId" HeaderText="ID" />
                <asp:BoundField DataField="StudentNumber" HeaderText="Student Number" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Created" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
