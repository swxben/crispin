using System.Diagnostics;
using System.IO;

namespace crispin
{
    public partial class ReportingService : IReportingService
    {
        public void OpenAsPdf(string xrpt, string reportName)
        {
            var dest = Path.GetTempFileName();
            File.WriteAllBytes(dest, ConvertToPdf(xrpt, reportName));
            var newDest = Path.Combine(
                // ReSharper disable once AssignNullToNotNullAttribute
                Path.GetDirectoryName(dest),
                Path.GetFileNameWithoutExtension(dest) + ".pdf");
            File.Move(dest, newDest);
            Process.Start(newDest);
        }

        public byte[] ConvertToPdf(string xrpt, string reportName)
        {
            return new PdfReportConverter()
                .ConvertToBuffer(xrpt, reportName);
        }

        public string ConvertToCsv(string xrpt)
        {
            return new CsvReportConverter().ConvertToString(xrpt);
        }

        public string ConvertToHtml(string xrpt)
        {
            return new HtmlReportConverter().ConvertToString(xrpt);
        }
    }
}
