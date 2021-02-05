<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AS_Assignment.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
</head>
<body>
    <p>
        <br />
    </p>
    <form id="form1" runat="server">
        <p>
            <asp:Label ID="lbl_msg" runat="server" EnableViewState="false"></asp:Label>
        </p>
        <p>
            User Profile Details</p>
        <p>
            Name:
            <asp:Label ID="name_lbl" runat="server" Text="Label"></asp:Label>
        </p>
        <p>
            Email:
            <asp:Label ID="email_lbl" runat="server" Text="Label"></asp:Label>
        </p>
        <div>
            <asp:Button ID="btn_logout" runat="server" Text="Logout" Width="108px" OnClick="btn_logout_Click"/>
        </div>
    </form>
</body>
</html>
