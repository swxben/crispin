using System;
using System.Collections.Generic;
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
                 new StaticTest1(),
                 new CustomPageSetupTest(),
                 new TableBackgroundTest(),
                 new LeftPaddedTable(),
                 new swxben_reporting_razor_example()
            };
            var converters = new IReportConverter[] {
                new CsvReportConverter(),
                new HtmlReportConverter(),
                new PdfReportConverter()
            };

            int reportIndex = GetReportIndex(reports);
            var xrpt = reports[reportIndex - 1].TransformText();
            Console.WriteLine("Generated report:");
            Console.WriteLine(xrpt);
            WriteToFile(xrpt, "xrpt.txt");

            int converterIndex = GetConverterIndex(converters);
            int convertAction = GetConvertAction();
            var converter = converters.ToList()[converterIndex - 1];

            if (convertAction == 1)
            {
                var convertedReport = converter.ConvertToString(xrpt);
                Console.WriteLine("Converted report:");
                Console.WriteLine(convertedReport);
                WriteToFile(convertedReport, "conv.txt");
            }
            else if (convertAction == 2 || convertAction == 3)
            {
                var convertedReport = converter.ConvertToBuffer(xrpt, "TEST");
                Console.WriteLine("Converted to buffer.");
                var dest = convertAction == 2 ? "conv.bin" : "conv.pdf";
                WriteToFile(convertedReport, dest);
            }

            Console.WriteLine("Press any key to quit...");
            Console.ReadKey();
        }

        private static int GetConvertAction()
        {
            while (true)
            {
                Console.WriteLine("Convert to (1) string (2) byte array (3) PDF:");
                int convertAction = 0;
                var s = Console.ReadLine();
                if (!int.TryParse(s.Trim(), out convertAction) || (
                    convertAction != 1 &&
                    convertAction != 2 &&
                    convertAction != 3))
                {
                    Console.WriteLine("Invalid converter action");
                }
                else return convertAction;
            }
        }

        private static void WriteToFile(string xrpt, string filename)
        {
            if (File.Exists(filename)) File.Delete(filename);
            File.WriteAllText(filename, xrpt);
            Console.WriteLine("Wrote to " + filename);
        }

        static void WriteToFile(byte[] buffer, string filename)
        {
            if (File.Exists(filename)) File.Delete(filename);
            File.WriteAllBytes(filename, buffer);
            Console.WriteLine("Wrote to " + filename);
        }

        private static int GetConverterIndex(IEnumerable<IReportConverter> converters)
        {
            Console.WriteLine("Select converter:");

            int converterIndex = 1;
            foreach (var converter in converters)
            {
                Console.WriteLine("    " + converterIndex.ToString() + ". " + converter.GetType().ToString());
                converterIndex++;
            }

            converterIndex = 0;
            while (true)
            {
                var s = Console.ReadLine();
                if (!int.TryParse(s.Trim(), out converterIndex) || converterIndex < 1 || converterIndex > converters.Count())
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
