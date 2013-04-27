using System.Diagnostics;
using System.IO;

namespace crispin
{
    public partial class ReportingService : IReportingService
    {
        public void OpenAsPdf(string xrpt, string reportName)
        {
            var converter = new PdfReportConverter();
            var bytes = converter.ConvertToBuffer(xrpt, reportName);
            var dest = Path.GetTempFileName();
            File.WriteAllBytes(dest, bytes);
            var newDest = Path.Combine(
                Path.GetDirectoryName(dest),
                Path.GetFileNameWithoutExtension(dest) + ".pdf");
            File.Move(dest, newDest);
            Process.Start(newDest);
        }
    }
}
