using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;
using swxben.reporting.Helpers;

namespace swxben.reporting
{
    public class PdfReportConverter : IReportConverter
    {
        XslCompiledTransform _xslt = XsltLoader.LoadFromAssembly("swxben.reporting.xslt.XrptToXslFo.xslt");

        public void ReplaceXslt(XslCompiledTransform xslt)
        {
            _xslt = xslt;
        }

        public string ConvertToString(string xrpt)
        {
            var xml = new XmlDocument();
            xml.LoadXml(StripByteOrderMark.Strip(xrpt));
            return GetXslfoText(xml);
        }

        public byte[] ConvertToBuffer(string xrpt, string reportName)
        {
            var xml = new XmlDocument();
            xml.LoadXml(StripByteOrderMark.Strip(xrpt));
            var tempImagePaths = HandleNonJpegImages(xml).ToList();

            var xslfoText = GetXslfoText(xml);

            var pdfData = GetPdfData(xslfoText, reportName);

            DeleteTempImages(tempImagePaths);

            return pdfData;
        }

        private string GetXslfoText(IXPathNavigable xml)
        {
            using (var writer = new StringWriter())
            using (var xmlWriter = new XmlTextWriter(writer))
            {
                xmlWriter.Formatting = Formatting.Indented;

                xmlWriter.WriteStartDocument();
                _xslt.Transform(xml, null, xmlWriter, new XmlUrlResolver());

                return writer.ToString()
                                  .Replace(Convert.ToString((char) 160), "&#160;")
                                  .Replace("&nbsp;", "&#160;")
                                  .Replace("&ldquo;", "&#8220;")
                                  .Replace("&lsquo;", "&#8216;")
                                  .Replace("&rdquo;", "&#8221;")
                                  .Replace("&rsquo;", "&#8217;")
                                  .Replace("&quot;", "&#34;");
            }
        }

        static void DeleteTempImages(IEnumerable<string> tempImagePaths)
        {
            foreach (var path in tempImagePaths)
            {
                try { File.Delete(path); }
                catch { }
            }
        }

        static byte[] GetPdfData(string xslfoText, string reportName)
        {
            try
            {
                return FopInterface.ProcessXslFo(xslfoText, reportName);
            }
            catch (Exception ex)
            {
                throw new Exception(
                    string.Format("Report content: {0}", xslfoText),
                    ex);
            }
        }

        IEnumerable<string> HandleNonJpegImages(XmlDocument xml)
        {
            foreach (XmlNode node in xml.GetElementsByTagName("img"))
            {
                var destPath = "";

                try
                {
                    if (node.Attributes["srctype"] != null && node.Attributes["srctype"].Value.ToLower() == "png")
                    {
                        destPath = ConvertPngToJpeg(node.Attributes["src"].Value.Replace("&amp;", "&"));
                    }
                    else if (node.Attributes["src"] != null && node.Attributes["src"].Value.ToLower().StartsWith("data:"))
                    {
                        if (!node.Attributes["src"].Value.ToLower().StartsWith("data:image/jpeg") && !node.Attributes["src"].Value.ToLower().StartsWith("data:image/jpg"))
                        {
                            destPath = ConvertUrlEncodedImageToJpeg(node.Attributes["src"].Value);
                            node.Attributes["src"].Value = string.Format(
                                "file:///{0}",
                                destPath.Replace(@":\", ":///").Replace(@"\", "/"));
                        }
                    }
                }
                catch { }

                if (!string.IsNullOrEmpty(destPath)) yield return destPath;
            }
        }

        private static string ConvertUrlEncodedImageToJpeg(string uri)
        {
            var buffer = Convert.FromBase64String(uri.Substring(uri.IndexOf(",", StringComparison.Ordinal) + 1, uri.Length - uri.IndexOf(",", StringComparison.Ordinal) - 1));
            var image = Image.FromStream(new MemoryStream(buffer));
            var destPath = Path.GetTempFileName();

            image.Save(destPath, ImageFormat.Jpeg);

            return destPath;
        }

        private static string ConvertPngToJpeg(string sourceUrl)
        {
            using (var stream = new WebClient().OpenRead(sourceUrl))
            {
                var image = Image.FromStream(stream);
                var destPath = Path.GetTempFileName();
                image.Save(destPath, ImageFormat.Jpeg);
                return destPath;
            }
        }
    }
}
