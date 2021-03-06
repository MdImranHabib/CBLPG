<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Declined.aspx.cs" Inherits="CBLPG.Declined" ValidateRequest="false" %>

<%@ Import Namespace="CBLPG" %>
<%@ Import Namespace="System.Xml" %>

<html>
    <body>
	    <h2>Declined Order Details</h2>
	    <form action="http://localhost:50826/index.aspx">            
            <table cellpadding="0" cellspacing="0">
            <%
                Functions theFunctions = new Functions();
                XmlDocument xmlDoc = new XmlDocument();

                String OrderID = "";
                String TransactionType = "";
                String Currency = "";
                String PurchaseAmount = "";
                String OrderStatus = "";
                String PAN = "";
                             
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
                        
                        if (OrderID == Session["OrderID"].ToString())
                        {
                            String data = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                            data += "<TKKPG>";
                            data += "<Request>";
                            data += "<Operation>GetOrderInformation</Operation>";
                            data += "<Language>EN</Language>";
                            data += "<Order>";
                            data += "<Merchant>" + Session["Merchant"] + "</Merchant>";
                            data += "<OrderID>" + Session["OrderID"] + "</OrderID>";
                            data += "</Order>";
                            data += "<SessionID>" + Session["SessionID"] + "</SessionID>";
                            data += "<ShowParams>true</ShowParams>";
                            data += "<ShowOperations>false</ShowOperations>";
                            data += "<ClassicView>true</ClassicView>";
                            data += "</Request></TKKPG> ";

                            String response = Functions.PostQW(data);
                            XmlDocument xml = new XmlDocument();
                            xml.LoadXml(response.Substring(response.IndexOf("<TKKPG>")));

                            //Extract additional parameters for verification
                            XmlNodeList xmlNodes = xml.SelectNodes("/TKKPG/Response/Order/row/OrderParams/row");
                            foreach (XmlNode node in xmlNodes)
                                if (node.ChildNodes.Item(0).InnerText == "PAN")
                                    PAN = node.ChildNodes.Item(1).InnerText;
                        }
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
            <tr>					
                <td align=left>PAN </td>
                <td align=left>=</td>
                <td align=right><%= PAN%></td>
	        </tr>
            </table>	
	
            <br/>
        <input type="submit" value="Back to Create Order"/>
	    </form>
	    <hr/>
    </body>
</html>