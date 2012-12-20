using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Xsl;
using System.Reflection;
using System.Xml;

namespace swxben.reporting.Helpers
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
                    new XsltSettings { EnableScript = true,  }, 
                    new XmlUrlResolver());
            }

            return xslt;
        }
    }
}
