using System;
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
                Console.WriteLine("2: Images");
                Console.WriteLine("Select report (1-2,q):");
                int report;
                var s = Console.ReadLine();
                if (s.Trim().ToLower() == "q") return;
                if (!int.TryParse(s.Trim(), out report) || (report != 1 && report != 2))
                {
                    Console.WriteLine("Invalid report");
                    continue;
                }

                if (report == 1) OpenTableBackgroundTest();
                if (report == 2) OpenImages();
            }
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
    }
}
