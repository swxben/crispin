using System.Xml.Xsl;

namespace crispin
{
    public interface IReportConverter
    {
        string ConvertToString(string xrpt);
        void ReplaceXslt(XslCompiledTransform xslt);
        byte[] ConvertToBuffer(string xrpt, string reportName);
    }
}
