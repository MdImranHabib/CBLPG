using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Text.RegularExpressions;
using System.Net;
using System.Collections.Specialized;
using System.IO;
using System.Reflection;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

namespace CityBankASP
{
    public partial class SampleCreateOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            JavaScriptSerializer json_serializer = new JavaScriptSerializer();

            string Merchant = "11122333";
            string PurchaseAmount = "100";
            string Description = "Test Product";

            string proxy = "";
            string proxyauth = "";
            string postDataToken = "{\"userName\":\"test\",\"password\":\"123456Aa\"}";
            string serviceUrltoken = "https://sandbox.thecitybank.com:7788/transaction/token";
            string certPath = Server.MapPath("/");

            string resToken = Functions.ProcessRequest(certPath, postDataToken, serviceUrltoken, proxy, proxyauth);

            dynamic resTokenList = JsonConvert.DeserializeObject(resToken);
            string txnID = resTokenList.transactionId;

            string serviceUrlEcom = "https://sandbox.thecitybank.com:7788/transaction/createorder";

            string postDataEcom = "{\"merchantId\":\"" + Merchant + "\","
                + "\"amount\":\"" + PurchaseAmount + "\","
                + "\"currency\":\"050\","
                + "\"description\":\"" + Description + "\","
                + "\"approveUrl\":\"http://localhost:50826/Approved.aspx\","
                + "\"cancelUrl\":\"http://localhost:50826/Cancelled.aspx\","
                + "\"declineUrl\":\"http://localhost:50826/Declined.aspx\","
                + "\"userName\":\"test\","
                + "\"passWord\":\"123456Aa\","
                + "\"secureToken\":\"" + txnID + "\"}";

            string resEcom = Functions.ProcessRequest(certPath, postDataEcom, serviceUrlEcom, proxy, proxyauth);
            dynamic resEcomList = JsonConvert.DeserializeObject(resEcom);

            string URL = resEcomList.items.url;
            string OrderID = resEcomList.items.orderId;
            string SessionID = resEcomList.items.sessionId;
                       
            //Call for Payment Page
            if (OrderID != "" && SessionID != "")
            {
                //Merchant have to store Created Order Details in Shop DB
                Session["Merchant"] = Merchant;
                Session["OrderID"] = OrderID;
                Session["SessionID"] = SessionID;
                Session["PurchaseAmount"] = PurchaseAmount;
                Session["Description"] = Description;
                Session["Status"] = "Created";

                Response.Redirect(URL + "?ORDERID=" + OrderID + "&SESSIONID=" + SessionID);
            }
            //if response.redirect return to approved.aspx and response status is
            //Approved then process the bottom code

            //$serviceUrlEcomm = 'https://sandbox.thecitybank.com:7788/transaction/getorderdetailsapi';
            //$curl = curl_init();

            //$postdataEcomm = '{
            //"orderID": "921766",
            //"sessionID": "7376F802C37866A12B56EE1FCEFE0BD0",
            //"merchantID": "11122333",
            //"userName": "test",
            //"passWord": "123456Aa",
            //"secureToken": "'.$transactionId.'"
            //}';

            //$cblEcomm = ProcessRequest($postdataEcomm,$serviceUrlEcomm,$proxy,$proxyauth);

            //print_r($cblEcomm);
        }
    }
}