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
            var htmlXslt = new XslCompiledTransform();
            using (var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream("swxben.reporting.xslt.XrptToHtml.xslt"))
            using (var reader = new XmlTextReader(stream))
            {
                htmlXslt.Load(reader);
            }

            Converters = new IReportConverter[] {
                new HtmlReportConverter(htmlXslt)
            };
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
