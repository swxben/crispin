using System.IO;
using crispin.ExampleReportLibrary;

namespace crispin.razor
{
    public class crispin_razor_example_runner
    {
        public void Run()
        {
            var report = new crispin_razor_example();
            var xrpt = report.TransformText();
            var converter = new PdfReportConverter();
            var pdfBits = converter.ConvertToBuffer(xrpt, "Example report");
            File.WriteAllBytes("output.pdf", pdfBits);
        }
    }
}
