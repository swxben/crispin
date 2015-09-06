using System;
using System.IO;
using System.Linq;
using System.Xml;

namespace crispin
{
    internal static class InternalHelpers
    {
        internal static string GetXml(XmlNode node)
        {
            using (var stringWriter = new StringWriter())
            using (var xmlTextWriter = XmlWriter.Create(stringWriter))
            {
                node.WriteTo(xmlTextWriter);
                xmlTextWriter.Flush();
                return stringWriter.GetStringBuilder().ToString();
            }
        }

        internal static void PreprocessSvgElementsIntoInlineDataUrls(XmlDocument doc)
        {
            // FOP seems to support SVG images either loaded externally or from
            // a base64 encoded url, but not as an embedded SVG document. So...
            // replace all svg elements that don't have a src attribute with
            // the base64 encoded equivalent
            var svgElements = doc.GetElementsByTagName("svg").Cast<XmlNode>()
                .Where(x => x.Attributes["src"] == null)
                .ToArray();

            foreach (var svgElement in svgElements)
            {
                var svgXml = GetXmlFragment(svgElement);

                var srcAttribute = doc.CreateAttribute("src");
                srcAttribute.Value = "data:image/svg+xml;base64," + Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(svgXml));

                var newElement = doc.CreateElement("svg");
                newElement.Attributes.Append(srcAttribute);

                // copy all the other attributes (height, width)
                foreach (var a in svgElement.Attributes.Cast<XmlAttribute>().ToArray())
                {
                    if (a.Name == "xmlns" || a.Name == "version")
                    {
                        continue;
                    }
                    var newAttribute = doc.CreateAttribute(a.Name);
                    newAttribute.Value = a.Value;
                    newElement.Attributes.Append(newAttribute);
                }

                svgElement.ParentNode.InsertAfter(newElement, svgElement);
                svgElement.ParentNode.RemoveChild(svgElement);
            }
        }
        static string GetXmlFragment(XmlNode node)
        {
            using (var stringWriter = new StringWriter())
            using (var xmlFragmentWriter = new XmlFragmentWriter(stringWriter))
            {
                xmlFragmentWriter.Formatting = Formatting.Indented;
                node.WriteTo(xmlFragmentWriter);
                return stringWriter.GetStringBuilder().ToString();
            }
        }
    }
}
