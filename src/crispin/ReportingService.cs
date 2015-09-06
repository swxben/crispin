using System.Diagnostics;
using System.IO;

namespace crispin
{
    public class ReportingService : IReportingService
    {
        public void OpenAsPdf(string xrpt, string reportName)
        {
            var dest = Path.GetTempFileName();

            File.WriteAllBytes(dest, ConvertToPdf(xrpt, reportName));

            var newDest = RenameExtension(dest, "pdf");

            Process.Start(newDest);
        }

        private static string RenameExtension(string dest, string extension)
        {
            var newDest = Path.Combine(
                // ReSharper disable once AssignNullToNotNullAttribute
                Path.GetDirectoryName(dest),
                Path.GetFileNameWithoutExtension(dest) + "." + extension);

            File.Move(dest, newDest);

            return newDest;
        }

        public void OpenAsHtml(string xrpt)
        {
            var dest = Path.GetTempFileName();

            File.WriteAllText(dest, ConvertToHtml(xrpt));

            var newDest = RenameExtension(dest, "html");

            Process.Start(newDest);
        }

        public void OpenAsCsv(string xrpt)
        {
            var dest = Path.GetTempFileName();

            File.WriteAllText(dest, ConvertToCsv(xrpt));

            var newDest = RenameExtension(dest, "csv");

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
