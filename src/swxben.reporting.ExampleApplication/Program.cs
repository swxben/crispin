using System;
using swxben.reporting.ExampleReportLibrary;
using System.Collections.Generic;
using System.Linq;
using RazorGenerator.Templating;

namespace swxben.reporting.ExampleApplication
{
    class Program
    {
        static void Main(string[] args)
        {
            var reports = new RazorTemplateBase [] {
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

            Console.WriteLine("Select report:");
            var i  =1;
            foreach (var report in reports)
            {
                Console.WriteLine("    " + i.ToString() + ". " + report.GetType().ToString());
                i++;
            }

            int reportIndex;
            while (true)
            {
                var s = Console.ReadLine();
                if (!int.TryParse(s.Trim(), out reportIndex) || reportIndex < 1 || reportIndex > reports.Count())
                {
                    Console.WriteLine("Invalid report");
                }
                else break;
            }

            var xrpt = reports[reportIndex - 1].TransformText();

            Console.WriteLine("Generated report:");
            Console.WriteLine(xrpt);
            Console.WriteLine("Press any key to quit...");
            Console.Read();
        }
    }
}
