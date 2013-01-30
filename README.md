swxben.reporting
================

Reporting library, using Razor templates to generate HTML, Excel and PDF reports


## Installation

Although the example library and documentation uses Razor as the template engine, the report library itself will accept input from any source, including static XML. To use Razor, install the [Razor Generator](http://razorgenerator.codeplex.com/) VS extension first.

Install the engine via [NuGet](http://nuget.org/packages/swxben.reporting), either in Visual Studio (right-click project, Manage NuGet Packages, search for `swxen.reporting`) or via the package manager console using `Install-Package swxben.reporting`.

There is also a [Razor example package](http://nuget.org/packages/swxben.reporting.razor) which includes `swxben.reporting` and some examples to get started. A [swxben.reporting.System.Web package](http://nuget.org/packages/swxben.reporting.System.Web) is used to replace basic Razor features found via `System.Web` such as automatic HTML encoding and `Html.Raw()` that aren't found in Razor Generator's template library without having to depend on `System.Web`.


## Usage

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


### Reporting service

The `ReportingService` class contains helpers for transforming and managing reports. It implements `IReportingService` for DI goodyness:

    IReportingService reportingService = new ReportingService();

#### PDF functions

##### OpenAsPdf

Saves the report to a temporary file then opens it using `Process.Start`.

    reportingService.OpenAsPdf(report.TransformText(), "Name of report");


### swxben.reporting.System.Web

Minimal workarounds to support `System.Web` assumptions built in to Razor features such as `Html.Raw()`, automatic HTML encoding (eg `@("<em>&</em>")), helpers and `IHtmlString`. Make the template inherit from `System.Web.Razor.CustomRazorTemplateBase` to get the features to work properly.

	@* Generator: Template *@<?xml version="1.0" encoding="UTF-8" ?>
	@inherits System.Web.Razor.CustomRazorTemplateBase
	...
	@helper Embolden(string s) {
		<strong>@s</strong>
	}
	@{
		var subtemplate = new Subtemplate();
	}
	...
	<p>Escape plain at values: @("<em>not emphasised</em>")</p> 
	<p>Html.Raw(): @Html.Raw("<em>emphasised</em>")</p>
	<p>Embolden helper: @Embolden("emboldened")</p>
	<p>@Html.Raw(subtemplate.TransformText())</p>

#### System.Web.Mvc.HtmlHelper

A protected instance of `System.Web.Mvc.HtmlHelper` is exposed in `System.Web.Razor.CustomRazorTemplateBase` as `Html`. The only method implemented is `Raw()` which just returns the input as a `IHtmlString` to avoid automatic HTML encoding.

#### System.Web.WebPages.HelperResult

This is used in the class generated from the Razor template to implement helpers.

#### System.Web.IHtmlString

See <http://msdn.microsoft.com/en-us/library/system.web.ihtmlstring.aspx>.


## Contribute

If you want to contribute to this project, start by forking the repo: <https://github.com/swxben/swxben.reporting>. Create an issue if applicable, create a branch in your fork, and create a pull request when it's ready. Thanks!

### Contributors


## Building, running tests and the NuGet package

THe VS2010 solution is in the root folder. Unit tests (coming up) can be run in a console using `tests.bat`. The NuGet package can be built by running `build-nuget-package.cmd`.

### Upgrading FOP and IKVM

[Apache FOP](http://xmlgraphics.apache.org/fop/) is used to convert XSL-FO into a PDF but it is written in Java, so [IKVM](http://www.ikvm.net) is used to convert FOP into a .NET assembly and to provide a Java runtime to FOP.

The IKVM dependency is managed via NuGet but the FOP assembly is created and upgraded manually. To upgrade FOP (including to support new versions of IKVM):

1. Download the latest or target version of IKVM from <http://www.ikvm.net> (you need a BIN release)
2. Download the latest binary release of Apache FOP from <http://xmlgraphics.apache.org/fop/>
3. Decompress both packages to the desktop
4. Open a console and cd to `%DESKTOP%\fop-x.xx\lib\`
5. Run: `..\..\<path to ikvm>\bin\ikvmc -out:fop-x.xx.dll *.jar ..\build\fop.jar`

A number of warnings and errors will come up, hopefully they can be ignored and the new `fop-x.xx.dll` file will be created in `<ikvm>\bin\`. Copy the DLL to the `swxben.reporting/lib` folder and update the FOP reference to the new assembly. Note that the IKVM version used to create the FOP assembly needs to match the IKVM version used by `swxben.reporting`.


## Licenses

All files [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/) unless otherwise specified.

### Third party licenses

Third party libraries or resources have been included in this project under their respective licenses.

- [Apache FOP](http://xmlgraphics.apache.org/fop/) uses the [Apache License, version 2.0](http://xmlgraphics.apache.org/fop/license.html)
- [IKVM](http://www.ikvm.net) is [Copyright (C) Jeroen Frijters](https://sourceforge.net/apps/mediawiki/ikvm/index.php?title=License) with permission for commercial use
	- IKVM uses code from the OpenJDK, GNU Classpath and IcedTea projects which are licensed under the GPL v2 + "Classpath" exception

> Copyright (C) 2002-2012 Jeroen Frijters
> 
> This software is provided 'as-is', without any express or implied
> warranty. In no event will the authors be held liable for any damages
> arising from the use of this software.
> 
> Permission is granted to anyone to use this software for any purpose,
> including commercial applications, and to alter it and redistribute it
> freely, subject to the following restrictions:
> 
> 1. The origin of this software must not be misrepresented; you must not
>    claim that you wrote the original software. If you use this software
>    in a product, an acknowledgment in the product documentation would be
>    appreciated but is not required.
> 2. Altered source versions must be plainly marked as such, and must not be
>    misrepresented as being the original software.
> 3. This notice may not be removed or altered from any source distribution.
> 
> Jeroen Frijters
> jeroen@frijters.net




