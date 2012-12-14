using System;
using System.IO;
using System.Linq;
using RazorGenerator.Templating;
using swxben.reporting.ExampleReportLibrary;

namespace swxben.reporting.ExampleApplication
{
    class Program
    {
        static void Main(string[] args)
        {
            var reports = new RazorTemplateBase[] {
                new Report1 {
                        Packages = new Package[] {
                            new Package{ Origin = "Cracow", Destination = "Dululu", Cost = 15.0m },
                            new Package{ Origin = "Emerald", Destination = "Dingo", Cost = 15.0m },
                            new Package{ Origin = "Duaringa", Destination = "Gladstone", Cost = 12.5m },
                            new Package{ Origin = "Dingo", Destination = "Dingo", Cost = 16.0m },
                            new Package{ Origin = "Dululu", Destination = "Duaringa", Cost = 12.5m },
                            new Package{ Origin = "Gladstone", Destination = "Dululu", Cost = 8.5m }
                        }
                 },
                 new StaticTest1()
            };
            var converterFactory = new ReportConverterFactory();

            int reportIndex = GetReportIndex(reports);
            var xrpt = reports[reportIndex - 1].TransformText();
            Console.WriteLine("Generated report:");
            Console.WriteLine(xrpt);
            WriteToFile(xrpt, "xrpt.txt");

            Console.WriteLine("Select converter:");
            int converterIndex = GetConverterIndex(converterFactory);
            var convertedReport = converterFactory.Converters.ToList()[converterIndex - 1].ConvertToString(xrpt);
            Console.WriteLine("Converted report:");
            Console.WriteLine(convertedReport);
            WriteToFile(convertedReport, "conv.txt");

            Console.WriteLine("Press any key to quit...");
            Console.Read();
        }

        private static void WriteToFile(string xrpt, string filename)
        {
            if (File.Exists(filename)) File.Delete(filename);
            File.WriteAllText(filename, xrpt);
            Console.WriteLine("Wrote to " + filename);
        }

        private static int GetConverterIndex(ReportConverterFactory converterFactory)
        {
            int converterIndex = 1;
            foreach (var converter in converterFactory.Converters)
            {
                Console.WriteLine("    " + converterIndex.ToString() + ". " + converter.GetType().ToString());
                converterIndex++;
            }

            converterIndex = 0;
            while (true)
            {
                var s = Console.ReadLine();
                if (!int.TryParse(s.Trim(), out converterIndex) || converterIndex < 1 || converterIndex > converterFactory.Converters.Count())
                {
                    Console.WriteLine("Invalid converter");
                }
                else break;
            }
            return converterIndex;
        }

        private static int GetReportIndex(RazorTemplateBase[] reports)
        {
            Console.WriteLine("Select report:");
            int reportIndex = 1;
            foreach (var report in reports)
            {
                Console.WriteLine("    " + reportIndex.ToString() + ". " + report.GetType().ToString());
                reportIndex++;
            }

            reportIndex = 0;
            while (true)
            {
                var s = Console.ReadLine();
                if (!int.TryParse(s.Trim(), out reportIndex) || reportIndex < 1 || reportIndex > reports.Count())
                {
                    Console.WriteLine("Invalid report");
                }
                else break;
            }
            return reportIndex;
        }
    }
}
