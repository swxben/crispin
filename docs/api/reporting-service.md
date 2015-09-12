The `ReportingService` class contains helpers for transforming and managing reports. It implements `IReportingService` for DI goodyness:

    IReportingService reportingService = new ReportingService();

    // or, with Autofac:

    builder.RegisterType<ReportingService>().As<IReportingService>();


#### OpenAsPdf

Converts the report markup to a PDF and saves it to a temporary file, then opens it using `Process.Start`.

    reportingService.OpenAsPdf(report.TransformText(), "Name of report");

#### ConvertToPdf

Converts the report markup to a PDF and returns a byte array containing the PDF.

	var buf = reportingService.ConvertToPdf(report.TransformText(), "Name of report");

#### ConvertToCsv

Converts the report markup to a CSV (comma separated value) formatted string, by exporting any `table` elements with a `type` attribute equal to `DataGrid` or `Data` (`<table type="DataGrid">`).

	var csv = reportingService.ConvertToCsv(report.TransformText());

#### ConvertToHtml

Converts the report markup to HTML.

	var html = reportingService.ConvertToCsv(report.TransformText());


