namespace System.Web
{
    public interface IHtmlString
    {
        string ToHtmlString();
    }

    internal class HtmlString : IHtmlString
    {
        string _value;

        public HtmlString(string value)
        {
            _value = value;
        }

        public string ToHtmlString()
        {
            return _value;
        }
    }
}
