<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cancelled.aspx.cs" Inherits="CityBankASP.Cancelled" ValidateRequest="false" %>

<%@ Import Namespace="CityBankASP" %>
<%@ Import Namespace="System.Xml" %>

<html>
    <body>
	    <h2>Cancelled Order Details</h2>
	    <form action="http://localhost:50826/index.aspx">            
            <table cellpadding="0" cellspacing="0">
            <%
                Functions theFunctions = new Functions();
                XmlDocument xmlDoc = new XmlDocument();
                                       
                string OrderID 	= "";
                string TransactionType 	= "";
                string Currency = "";
                string PurchaseAmount = "";
                string OrderStatus = "";
                    
                if(Request["xmlmsg"] != "")
                {                    
                    try 
                    {                        
                        //For getting the required values
                        xmlDoc.LoadXml(Request["xmlmsg"]);
                        XmlNodeList nodeList = xmlDoc.SelectNodes("/Message");
                        
                        OrderID = nodeList.Item(0)["OrderID"].InnerText;
                        TransactionType = nodeList.Item(0)["TransactionType"].InnerText;
                        Currency = nodeList.Item(0)["Currency"].InnerText;
                        PurchaseAmount = nodeList.Item(0)["PurchaseAmount"].InnerText;
                        OrderStatus = nodeList.Item(0)["OrderStatus"].InnerText;
                    }
                    catch (Exception) { }
                }
            %>
                            
	        <tr>					
                <td align=left>Order ID </td>
                <td align=left>=</td>
                <td align=right><%= OrderID %></td>
	        <tr>                
	        <tr>					
                <td align=left>Transaction Type </td>
                <td align=left>=</td>
                <td align=right><%= TransactionType %></td>
	        <tr>
	        <tr>					
                <td align=left>Currency </td>
                <td align=left>=</td>
                <td align=right><%= Currency %></td>
	        </tr>
	        <tr>					
                <td align=left>Purchase Amount </td>
                <td align=left>=</td>
                <td align=right><%= int.Parse(PurchaseAmount) / 100 %></td>
	        </tr>
            <tr>					
                <td align=left>Order Status </td>
                <td align=left>=</td>
                <td align=right><%= OrderStatus %></td>
	        </tr>
            </table>	
	
            <br/>
        <input type="submit" value="Back to Create Order"/>
	    </form>
	    <hr/>
    </body>
</html>