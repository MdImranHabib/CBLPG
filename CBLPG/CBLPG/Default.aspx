<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="CBLPG._Default" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<html>
    <body>
	<h1>Test Merchant of CBLPG (JSP)</h1>
	<h2>Create Order Operation</h2>
	<form method="post" action="http://127.0.0.1:8080/CreateOrder.jsp">
            <table cellpadding="0" cellspacing="0">
		<tr>					
                    <td><p>Merchant :</p></td>
                    <td><input type="text" size="25" name="Merchant" value="9100000017" readonly/></td>				</tr>
		<tr>
		<td>
                    <p>Amount :</p></td>
                    <td><input type="text" size="25" name="Amount" value="100"/></td>
		</tr>
		<tr>
                    <td><p>Currency :</p></td>
                    <td><input type="text" size="25" name="Currency" value="050" readonly/></td>
		</tr>
		<tr>
                    <td><p>Description :</p></td>
                    <td><input type="text" size="25" name="Description" value="Test Product"/></td>
		</tr>
                <tr>
                    <td><p>ApproveURL :</p></td>
                    <td><input type="text" size="50" name="ApproveURL" value="http://127.0.0.1:8080/Approved.jsp" readonly/></td>
		</tr>
		<tr>
                    <td><p>CancelURL :</p></td>
                    <td><input type="text" size="50" name="CancelURL" value="http://127.0.0.1:8080/Cancelled.jsp" readonly/></td>
		</tr>
		<tr>
                    <td><p>DeclineURL :</p></td>
                    <td><input type="text" size="50" name="DeclineURL" value="http://127.0.0.1:8080/Declined.jsp" readonly/></td>
		</tr>
            </table>	
	
            <br/>
            <input type="submit" value="Create Order"/>
	</form>
	<hr/>
    </body>
</html>

</asp:Content>
