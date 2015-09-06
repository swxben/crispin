using System;
using System.Diagnostics;
using System.IO;
using crispin.ExampleReportLibrary;

namespace crispin.ExampleApplication
{
    public static class TestSuiteTwo
    {
        static readonly IReportingService ReportingService = new ReportingService();

        public static void Go()
        {
            while (true)
            {
                Console.WriteLine("1: TableBackgroundTest");
                Console.WriteLine("2: Images (PDF)");
                Console.WriteLine("3: Images (HTML)");
                Console.WriteLine("4: Images (XSL:FO)");
                Console.WriteLine("Select report (1-4,q):");
                int report;
                var s = Console.ReadLine();
                if (s.Trim().ToLower() == "q") return;
                if (!int.TryParse(s.Trim(), out report) || !(1 <= report && report <= 4))
                {
                    Console.WriteLine("Invalid report");
                    continue;
                }

                if (report == 1) OpenTableBackgroundTest();
                if (report == 2) OpenImages();
                if (report == 3) OpenImagesHtml();
                if (report == 4) OpenImagesXslFo();
            }
        }

        static void OpenImagesXslFo()
        {
            var report = new Images();
            var fo = new PdfReportConverter().ConvertToString(report.TransformText());
            OpenMarkupAsText(fo);
        }

        private static void OpenTableBackgroundTest()
        {
            var report = new TableBackgroundTest();
            ReportingService.OpenAsPdf(report.TransformText(), "Table background test");
        }

        private static void OpenImages()
        {
            var report = new Images();
            ReportingService.OpenAsPdf(report.TransformText(), "Images");
        }

        private static void OpenImagesHtml()
        {
            var report = new Images();
            ReportingService.OpenAsHtml(report.TransformText());
        }

        static void OpenMarkupAsText(string markup)
        {
            var dest = Path.GetTempFileName();
            File.WriteAllText(dest, markup);
            var newDest = RenameExtension(dest, "txt");
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
    }
}
