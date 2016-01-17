using System;

namespace crispin
{
    public class PdfReportConverterException : Exception
    {
        public PdfReportConverterException(Exception ex, string reportContent)
            : base("Error converting XSL-FO to PDF", ex)
        {
            ReportContent = reportContent;
        }

        public string ReportContent { get; private set; }
    }
}