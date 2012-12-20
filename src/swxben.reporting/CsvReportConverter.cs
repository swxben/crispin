using System.Text;
using System.Xml;
using System.Xml.Xsl;
using swxben.reporting.Helpers;

namespace swxben.reporting
{
    public class CsvReportConverter : IReportConverter
    {
        XslCompiledTransform _xslt = XsltLoader.LoadFromAssembly("swxben.reporting.xslt.XrptToCsv.xslt");

        public void ReplaceXslt(XslCompiledTransform xslt)
        {
            _xslt = xslt;
        }

        public string ConvertToString(string xrpt)
        {
            var xml = new XmlDocument();
            xml.LoadXml(StripByteOrderMark.Strip(xrpt));

            using (var writer = new StringWriterWithEncoding(Encoding.UTF8))
            {
                _xslt.Transform(xml, null, writer);

                return writer.ToString();
            }
        }

        public byte[] ConvertToBuffer(string xrpt, string reportName)
        {
            return Encoding.UTF8.GetBytes(ConvertToString(xrpt));
        }
    }
}
