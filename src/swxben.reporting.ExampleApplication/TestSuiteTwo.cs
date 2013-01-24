using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using swxben.reporting.ExampleReportLibrary;

namespace swxben.reporting.ExampleApplication
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
