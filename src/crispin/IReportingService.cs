namespace crispin
{
    public interface IReportingService
    {
        void OpenAsPdf(string xrpt, string reportName);
        byte[] ConvertToPdf(string xrpt, string reportName);
        string ConvertToCsv(string xrpt);
        string ConvertToHtml(string xrpt);
    }
}
