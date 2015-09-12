Crispin is a library that uses an XML syntax similar to HTML to render or generate reports in HTML, CSV and PDF. It does this using XSLT to transform the XML into different output formats. One of those formats is XSL-FO, which is then passed into a .NET build of Apache FOP, resulting in a PDF. The XML syntax can be generated using Razor templates.

The advantage of Crispin over tools such as Aspose or iTextSharp is the ability to render reports into multiple formats, and the use of XML for generating the report makes it easier to construct the report compared to building it up in code. An alternative could be printing a generated HTML document to a PDF printer driver such as CutePDF, but this is unreliable to use programmatically and difficult or impossible in a server environment such as Azure. Crispin doesn't rely on GDI+ and runs seamlessly in Azure websites.


## Is it legit?

It is in use in three production systems that I know of - a mature portfolio management product that has reports generated both on a desktop client app (WinForms) and an ASP.NET application. Another is an Azure website. One of the biggest benefits is that you have a single report specification, built up using domain objects, written in Razor and generated in multiple environments to different formats. It's not drag and drop pretty and you may have to use tables for layouts but you get solid, reliable results.






