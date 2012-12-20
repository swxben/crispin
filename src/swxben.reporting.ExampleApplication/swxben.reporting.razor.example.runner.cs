using System.IO;
using swxben.reporting.ExampleReportLibrary;

namespace swxben.reporting.razor
{
    public class swxben_reporting_razor_example_runner
    {
        public void Run()
        {
            var report = new swxben_reporting_razor_example();
            var xrpt = report.TransformText();
            var converter = new PdfReportConverter();
            var pdfBits = converter.ConvertToBuffer(xrpt, "Example report");
            File.WriteAllBytes("output.pdf", pdfBits);
        }
    }
}
