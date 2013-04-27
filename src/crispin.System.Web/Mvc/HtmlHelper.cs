namespace System.Web.Mvc
{
    public class HtmlHelper
    {
        public IHtmlString Raw(string value)
        {
            return new HtmlString(value);
        }
    }
}
