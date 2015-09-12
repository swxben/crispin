Although the example library and documentation uses Razor as the template engine, the report library itself will accept input from any source, including static XML. To use Razor, install the [Razor Generator](http://razorgenerator.codeplex.com/) VS extension first.

Install the engine via [NuGet](http://nuget.org/packages/crispin), either in Visual Studio (right-click project, Manage NuGet Packages, search for `crispin`) or via the package manager console using `Install-Package crispin`.

There is also a [Razor example package](http://nuget.org/packages/crispin.razor) which includes `swxben.crispin` and some examples to get started. A [crispin.System.Web package](http://nuget.org/packages/crispin.System.Web) is used to replace basic Razor features found via `System.Web` such as automatic HTML encoding and `Html.Raw()` that aren't found in Razor Generator's template library without having to depend on `System.Web`.


