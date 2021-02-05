<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AS_Assignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 112px;
        }
        .auto-style3 {
            width: 112px;
            height: 29px;
        }
        .auto-style4 {
            height: 29px;
            width: 696px;
        }
        .auto-style5 {
            width: 696px;
        }
        .auto-style6 {
            width: 224px;
        }
        .auto-style7 {
            height: 29px;
            width: 224px;
        }
    </style>

     <script src="https://www.google.com/recaptcha/api.js?render=6LfF9zoaAAAAABV8IS7YAjh1-9L8rTSOCx-49lcV"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style6">&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">Email:</td>
                    <td class="auto-style7">
                        <asp:TextBox ID="tb_email" runat="server" Width="248px"></asp:TextBox>

                    </td>
                    <td class="auto-style4">
                        &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tb_email" ErrorMessage="Email error, add a '@'" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red"></asp:RegularExpressionValidator></td>
                </tr>
                <tr>
                    <td class="auto-style2">Password:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="tb_pwd" runat="server" Width="248px" TextMode="Password"></asp:TextBox>
                    </td>
                    <td class="auto-style5">
                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ErrorMessage="Password is Required" ForeColor="Red" ControlToValidate="tb_pwd"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style6">
                        <asp:Button ID="btn_login" runat="server" Text="Login" Width="158px"  />
                    </td>
                    <td class="auto-style5">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style6">

                        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                        <script>
 grecaptcha.ready(function () {
     grecaptcha.execute(' 6LfF9zoaAAAAABV8IS7YAjh1-9L8rTSOCx-49lcV ', { action: 'Login' }).then(function (token) {
 document.getElementById("g-recaptcha-response").value = token;
 });
 });
                        </script>
                        <asp:Label ID="lbl_errmsg" runat="server" EnableViewState="false">Error Message</asp:Label>
                    </td>
                    <td class="auto-style5">

                        &nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
