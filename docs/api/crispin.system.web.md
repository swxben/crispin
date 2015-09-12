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

To output raw HTML:

	@Html.Raw("<p>Hi!</p>")

This could be used in a helper class to output a standard header:

	public static class ReportHelpers
	{
		public static IHtmlString GetStandardHeader(this HtmlHelper html)
		{
			return html.Raw(new HeaderReport().TransformText());
		}
	}

	@Html.GetStandardHeader()


#### System.Web.WebPages.HelperResult

This is used in the class generated from the Razor template to implement helpers.

#### System.Web.IHtmlString

See <http://msdn.microsoft.com/en-us/library/system.web.ihtmlstring.aspx>.
