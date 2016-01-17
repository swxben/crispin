using System;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;
using crispin.Helpers;

namespace crispin
{
    public class PdfReportConverter : IReportConverter
    {
        private XslCompiledTransform _xslt = XsltLoader.LoadFromAssembly("crispin.xslt.XrptToXslFo.xslt");

        public void ReplaceXslt(XslCompiledTransform xslt)
        {
            _xslt = xslt;
        }

        public string ConvertToString(string xrpt)
        {
            xrpt = Preprocess(xrpt);

            var xml = new XmlDocument();

            xml.LoadXml(StripByteOrderMark.Strip(xrpt.Trim()));

            return GetXslfoText(xml);
        }

        public byte[] ConvertToBuffer(string xrpt, string reportName)
        {
            xrpt = Preprocess(xrpt);

            var xml = new XmlDocument();
            xml.LoadXml(StripByteOrderMark.Strip(xrpt.Trim()));

            var xslfoText = GetXslfoText(xml);

            var pdfData = GetPdfData(xslfoText, reportName);

            return pdfData;
        }

        private static string Preprocess(string xrpt)
        {
            var doc = new XmlDocument();
            doc.LoadXml(xrpt);

            InternalHelpers.PreprocessSvgElementsIntoInlineDataUrls(doc);

            return InternalHelpers.GetXml(doc);
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

        private static byte[] GetPdfData(string xslfoText, string reportName)
        {
            try
            {
                return FopInterface.ProcessXslFo(xslfoText, reportName);
            }
            catch (Exception ex)
            {
                throw new PdfReportConverterException(ex, xslfoText);
            }
        }
    }
}