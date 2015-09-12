Either create a new library project or use an existing project. The report templates will be generated into .cs files via Razor. Install the [RazorGenerator.Templating](https://www.nuget.org/packages/RazorGenerator.Templating) package. Add a report template to the project as a text file with an extension of `.cshtml`. In the file's properties, change `Custom Tool` to `RazorGenerator`. A barebones report template has this format:

	@* Generator: Template *@<?xml version="1.0" encoding="UTF-8" ?>
	<!DOCTYPE report [
	]>
	<report>
		<title>...</title>
		<content>
			<pageSequence orientation="portrait">
				<htmlBlock>
					<h1>Report</h1>
				</htmlBlock>
			</pageSequence>
		</content>
	</report>

The XML is a bit verbose because the converter uses the same XML to generate the output in several methods including XSL-FO to produce PDFs which needs data about the layout of the resulting document.

This markup is then parsed by one of the report converters (`CsvReportConverter`, `HtmlReportConverter` and `PdfReportConverter), using XSLT to transform the report into the output format.

The `PdfReportConverter` transforms the report markup into XSL-FO, which is then processed by Apache FOP (a Java library, converted to .NET using IKVM) into PDF in memory.