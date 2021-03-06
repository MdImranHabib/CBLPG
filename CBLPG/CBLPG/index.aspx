<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="CBLPG.index" ValidateRequest="false" %>--%>
<html>
    <body>
	    <h1>Test Merchant of CBLPG (ASP.NET C#)</h1>
	    <h2>Create Order Operation</h2>
	    <form method="post" action="http://localhost:50826/CreateOrder.aspx">
            <table cellpadding="0" cellspacing="0">
		        <tr>
                    <td><p>Merchant :</p></td>
                    <td><input type="text" size="25" name="Merchant" value="11122333" readonly/></td>
                </tr>
		        <tr>
		            <td><p>Amount :</p></td>
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
                    <td><input type="text" size="50" name="ApproveURL" value="http://localhost:50826/Approved.aspx" readonly/></td>
		        </tr>
		        <tr>
                    <td><p>CancelURL :</p></td>
                    <td><input type="text" size="50" name="CancelURL" value="http://localhost:50826/Cancelled.aspx" readonly/></td>
		        </tr>                                                                
		        <tr>
                    <td><p>DeclineURL :</p></td>
                    <td><input type="text" size="50" name="DeclineURL" value="http://localhost:50826/Declined.aspx" readonly/></td>
		        </tr>
            </table>	
	
            <br/>
            <input type="submit" value="Create Order"/>
	    </form>
	    <hr/>
    </body>
</html>
