using crispin.ExampleReportLibrary;

namespace crispin.ExampleApplication
{
    public static class TestSuiteTwo
    {
        public static void Go()
        {
            var report = new TableBackgroundTest();
            IReportingService reportingService = new ReportingService();
            reportingService.OpenAsPdf(report.TransformText(), "Table background test");
        }
    }
}
