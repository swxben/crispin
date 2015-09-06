namespace crispin
{
    public interface IReportingService
    {
        void OpenAsPdf(string xrpt, string reportName);
        void OpenAsHtml(string xrpt);
        void OpenAsCsv(string xrpt);
        byte[] ConvertToPdf(string xrpt, string reportName);
        string ConvertToCsv(string xrpt);
        string ConvertToHtml(string xrpt);
    }
}
