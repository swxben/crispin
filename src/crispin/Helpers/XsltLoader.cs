using System.Reflection;
using System.Xml;
using System.Xml.Xsl;

namespace crispin.Helpers
{
    static class XsltLoader
    {
        public static XslCompiledTransform LoadFromAssembly(string xsltName)
        {
            var xslt = new XslCompiledTransform();

            using (var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(xsltName))
            using (var reader = new XmlTextReader(stream))
            {
                xslt.Load(
                    reader,
                    new XsltSettings { EnableScript = true, },
                    new XmlUrlResolver());
            }

            return xslt;
        }
    }
}
