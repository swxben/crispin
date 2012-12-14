swxben.reporting
================

Reporting library, using Razor templates to generate HTML, Excel and PDF reports


## Installation

Although the example library and documentation uses Razor as the template engine, the report library itself will accept input from any source, including static XML. To use Razor, install the [Razor Generator](http://razorgenerator.codeplex.com/) VS extension first.

**NOT YET** Install the engine via [NuGet](http://nuget.org/packages/swxben.reporting), either in Visual Studio (right-click project, Manage NuGet Packages, search for `swxen.reporting`) or via the package manager console using `Install-Package swxben.reporting`.


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


## Contribute

If you want to contribute to this project, start by forking the repo: <https://github.com/swxben/swxben.reporting>. Create an issue if applicable, create a branch in your fork, and create a pull request when it's ready. Thanks!

### Contributors


## Building, running tests and the NuGet package

THe VS2010 solution is in the root folder. Unit tests (coming up) can be run in a console using `tests.bat`. The NuGet package can be built by running `build-nuget-package.cmd`.


## Licenses

All files [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/) unless otherwise specified.

### Third party licenses

Third party libraries or resources have been included in this project under their respective licenses.




