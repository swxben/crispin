using System.Globalization;
using System.IO;

namespace System.Web.WebPages
{
    public class HelperResult : IHtmlString
    {
        Action<TextWriter> _action;

        public HelperResult(Action<TextWriter> action)
        {
            _action = action;
        }

        public string ToHtmlString()
        {
            using (var writer = new StringWriter(CultureInfo.InvariantCulture))
            {
                _action(writer);
                return writer.ToString();
            }
        }

        public void WriteTo(TextWriter writer)
        {
            _action(writer);
        }
    }
}
