using System;

namespace crispin.ExampleApplication
{
    class Program
    {
        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("Select suite (1-2,q):");
                int suite;
                var s = Console.ReadLine();
                if (s.Trim().ToLower() == "q") return;
                if (!int.TryParse(s.Trim(), out suite) || (suite != 1 && suite != 2))
                {
                    Console.WriteLine("Invalid suite");
                    continue;
                }

                if (suite == 1) TestSuiteOne.Go();
                if (suite == 2) TestSuiteTwo.Go();
            }
        }
    }
}
