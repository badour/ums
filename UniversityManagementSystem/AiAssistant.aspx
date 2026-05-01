<%@ Page Title="AI Assistant" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AiAssistant.aspx.cs" Inherits="AiAssistant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>AI Assistant</h2>
    <p>Ask a question about the university data. The assistant uses live database context.</p>
    <asp:Label ID="lblError" runat="server" ForeColor="Red" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
    <div>
        <asp:Label ID="lblQuestion" runat="server" Text="Question:" AssociatedControlID="txtQuestion"></asp:Label><br />
        <asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" Rows="4" Width="700"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvQuestion" runat="server" ControlToValidate="txtQuestion" ErrorMessage="Question is required." ForeColor="Red" Display="Dynamic" />
    </div>
    <br />
    <asp:Button ID="btnAsk" runat="server" Text="Ask Assistant" OnClick="btnAsk_Click" />
    <hr />
    <asp:Panel ID="pnlAnswer" runat="server" Visible="false">
        <h3>Answer</h3>
        <asp:Literal ID="litAnswer" runat="server"></asp:Literal>
    </asp:Panel>
</asp:Content>
