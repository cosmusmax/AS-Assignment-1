<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="AS_Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Registration</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 165px;
        }
        .auto-style3 {
            width: 385px;
        }
        </style>

    <script src="https://www.google.com/recaptcha/api.js?render=6LfF9zoaAAAAABV8IS7YAjh1-9L8rTSOCx-49lcV"></script>

    <script type ="text/javascript">
        function validate() {
            var str = document.getElementById('<%=password_tb.ClientID %>').value;

            if (str.length < 8) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password Length Must be at least 8 Characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_number");
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 Upper case";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_uppercase");
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 Lower case";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_lowercase");
            }
            else if (str.search(/[^A-Za-z0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 Special symbol";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_specialcase");
            }

            document.getElementById("lbl_pwdchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_pwdchecker").style.color = "Blue";
        }
       
    </script>
</head>
    
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">First Name</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="firstname_tb" runat="server" Width="355px"></asp:TextBox>
                    </td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ErrorMessage="Firstname is Required" ForeColor="Red" ControlToValidate="firstname_tb"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="auto-style2">Last Name</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="lastname_tb" runat="server" Width="355px"></asp:TextBox>
                    </td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ErrorMessage="Lastname is Required" ForeColor="Red" ControlToValidate="lastname_tb"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="auto-style2">Credit Card Info</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="creditcard_tb" runat="server" Width="355px"></asp:TextBox>
                    </td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ErrorMessage="Credit Card is Required" ForeColor="Red" ControlToValidate="creditcard_tb"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="auto-style2">Email address</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="email_tb" runat="server" Width="355px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="email_tb" ErrorMessage="Email error, add a '@'" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Password</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="password_tb" runat="server" Width="355px" onkeyup="javascript:validate()"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lbl_pwdchecker" runat="server" Text="pwdchecker"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Date of Birth</td>
                    <td class="auto-style3">
                        <asp:TextBox ID="dob_tb" runat="server" Width="355px" TextMode="Date"></asp:TextBox>
                    </td>
                    <td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                            ErrorMessage="RequiredFieldValidator" ForeColor="Red" ControlToValidate="dob_tb"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style3">
                        <asp:Button ID="btn_register" runat="server" Text="Register" Width="235px" OnClick="btn_register_Click" />

                        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                        <script>
                            grecaptcha.ready(function () {
                                grecaptcha.execute(' 6LfF9zoaAAAAABV8IS7YAjh1-9L8rTSOCx-49lcV ', { action: 'Login' }).then(function (token) {
                                    document.getElementById("g-recaptcha-response").value = token;
                                });
                            });
                        </script>

                    </td>
                    <td>
                        &nbsp;</td>


                </tr>
            </table>
        </div>
    </form>
</body>
</html>
