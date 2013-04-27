using System.IO;
using System.Net;
using System.Web.Mvc;
using RazorGenerator.Templating;

namespace System.Web.Razor
{
    public class CustomRazorTemplateBase : RazorTemplateBase
    {
        HtmlHelper _html;
        protected HtmlHelper Html { get { return _html; } }

        public CustomRazorTemplateBase()
        {
            _html = new HtmlHelper();
        }

        public new void Write(object value)
        {
            if (ReferenceEquals(value, null)) return;
            base.Write(StringValueOf(value));
        }

        public new void WriteTo(TextWriter writer, object value)
        {
            if (ReferenceEquals(value, null)) return;
            writer.Write(StringValueOf(value));
        }

        public void WriteLiteralTo(TextWriter writer, string text)
        {
            writer.Write(text);
        }

        static string StringValueOf(object value)
        {
            return value is IHtmlString ? ((IHtmlString)value).ToHtmlString() : WebUtility.HtmlEncode(value.ToString());
        }
    }
}
