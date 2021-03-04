using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Security.Cryptography.X509Certificates;


namespace CityBankASP
{
    public class Functions
    {         
        public static String PostQW(String data)
        {
            //string hostName = "127.0.0.1";      
            string hostName = "192.168.0.174";      
            //int hostPort = 743;
            int hostPort = 50826;
            string headers;
            string response = "";
        
            // Start Socket
            Socket sk = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            System.Net.IPAddress remoteIPAddress = System.Net.IPAddress.Parse(hostName);
            System.Net.IPEndPoint remoteEndPoint = new System.Net.IPEndPoint(remoteIPAddress, hostPort);

            try
            {
                String path = "/Exec";

                headers = "POST " + path + " HTTP/1.0\r\n";
                headers += "Host: " + hostName + "\r\n";
                headers += "Content-type: text/xml\r\n";
                headers += "Content-Length: " + data.Length + "\r\n\r\n";
                headers += data;
                
                TcpClient tcpClient;
                NetworkStream networkStream;
                StreamWriter streamWriter;
                StreamReader streamReader;

                tcpClient = new TcpClient(hostName, hostPort);
                networkStream = tcpClient.GetStream();

                streamWriter = new StreamWriter(networkStream);
                streamReader = new StreamReader(networkStream);
                
                streamWriter.WriteLine(headers);
                streamWriter.Flush();

                response = streamReader.ReadToEnd();
                
                tcpClient.Close();
            }

            //Host not found
            catch (Exception ex)
            {
                return "Don't know about host : " + hostName + ex.Message;
            }

            return response;
        }

        public static string ProcessRequest(string certPath, string post_data_token, string service_url, string proxy, string proxyauth)
        {
            var result = "";
            //Following command need to execute to create single PFX certificate by SignedCert and Merchant PrivateKey 
            //openssl pkcs12 -export -out createorder.pfx -in createorder.crt -inkey createorder.key -password pass:02468

            var pfxPath = certPath + "createorder.pfx";
            string certificateText = File.ReadAllText(pfxPath);
            X509Certificate2 cert = new X509Certificate2(pfxPath, "02468");

            var request = (HttpWebRequest)WebRequest.Create(service_url);
            request.ContentType = "application/json";
            request.Method = "POST";
            request.ServerCertificateValidationCallback = (e, r, c, n) => true;
            request.ClientCertificates.Add(cert);

            using (var streamWriter = new StreamWriter(request.GetRequestStream()))
            {
                streamWriter.Write(post_data_token);
                streamWriter.Flush();
                streamWriter.Close();
            }

            var httpResponse = (HttpWebResponse)request.GetResponse();
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                result = streamReader.ReadToEnd();

            return result;
        }
    }
}