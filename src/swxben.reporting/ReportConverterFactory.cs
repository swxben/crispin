using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Xml;
using System.Xml.Xsl;

namespace swxben.reporting
{
    public class ReportConverterFactory
    {
        public IEnumerable<IReportConverter> Converters { get; private set; }

        public ReportConverterFactory()
        {
            var htmlXslt = GetXslt("swxben.reporting.xslt.XrptToHtml.xslt");
            var csvXslt = GetXslt("swxben.reporting.xslt.XrptToCsv.xslt");

            Converters = new IReportConverter[] {
                new HtmlReportConverter(htmlXslt),
                new CsvReportConverter(csvXslt)
            };
        }

        private static XslCompiledTransform GetXslt(string xsltName)
        {
            var xslt = new XslCompiledTransform();

            using (var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(xsltName))
            using (var reader = new XmlTextReader(stream))
            {
                xslt.Load(
                    reader, 
                    new XsltSettings { EnableScript = true,  }, 
                    new XmlUrlResolver());
            }

            return xslt;
        }

        public T GetConverter<T>() where T : IReportConverter
        {
            if (!Converters.OfType<T>().Any())
            {
                throw new InvalidOperationException(string.Format(
                    "The specified converter type ({0}) is not configured",
                    typeof(T).ToString()));
            }

            return Converters.OfType<T>().First();
        }
    }
}
