using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Xsl;
using System.Xml;
using swxben.reporting.Helpers;

namespace swxben.reporting
{
    public class CsvReportConverter : IReportConverter
    {
        XslCompiledTransform _xslt;

        public CsvReportConverter(XslCompiledTransform xslt)
        {
            _xslt = xslt;
        }

        public void ReplaceXslt(XslCompiledTransform xslt)
        {
            _xslt = xslt;
        }

        public string ConvertToString(string xrpt)
        {
            var xml = new XmlDocument();
            xml.LoadXml(xrpt);

            using (var writer = new StringWriterWithEncoding(Encoding.UTF8))
            {
                _xslt.Transform(xml, null, writer);

                return writer.ToString();
            }
        }
    }
}
