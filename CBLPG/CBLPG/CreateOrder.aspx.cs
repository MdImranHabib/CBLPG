using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Text.RegularExpressions;

namespace CBLPG
{
    public partial class CreateOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string OrderID = "";
            string SessionID = "";
            string URL = "";

            string str = Request["Merchant"];

            String data = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            data += "<TKKPG>";
            data += "<Request>";
            data += "<Operation>CreateOrder</Operation>";
            data += "<Language>EN</Language>";
            data += "<Order>";
            data += "<OrderType>Purchase</OrderType>";
            data += "<Merchant>" + Request["Merchant"] + "</Merchant>";
            data += "<Amount>" + int.Parse(Request["Amount"]) * 100 + "</Amount>";
            data += "<Currency>" + Request["Currency"] + "</Currency>";
            data += "<Description>" + Request["Description"] + "</Description>";
            data += "<ApproveURL>" + Request["ApproveURL"] + "</ApproveURL>";
            data += "<CancelURL>" + Request["CancelURL"] + "</CancelURL>";
            data += "<DeclineURL>" + Request["DeclineURL"] + "</DeclineURL>";
            data += "</Order></Request></TKKPG> ";

            String response = Functions.PostQW(data);

            XmlDocument xml = new XmlDocument();

            xml.LoadXml(response.Substring(response.IndexOf("<TKKPG>")));

            XmlNodeList nodeList = xml.SelectNodes("/TKKPG/Response/Order");

            OrderID = nodeList.Item(0)["OrderID"].InnerText;
            SessionID = nodeList.Item(0)["SessionID"].InnerText;
            URL = nodeList.Item(0)["URL"].InnerText;

            //Call for Payment Page
            if (OrderID != "" && SessionID != "")
            {
                //Merchant have to store Created Order Details in Shop DB
                Session["Merchant"] = Request["Merchant"];
                Session["OrderID"] = OrderID;
                Session["SessionID"] = SessionID;
                Session["PurchaseAmount"] = Request["Amount"];
                Session["Description"] = Request["Description"];
                Session["Status"] = "Created";
                Session["ApprovalCode"] = "";
                Session["PAN"] = "";

                Response.Redirect(URL + "?ORDERID=" + OrderID + "&SESSIONID=" + SessionID);
            }
        }
    }
}