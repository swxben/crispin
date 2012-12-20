using System.IO;
using RazorGenerator.Templating;

namespace swxben.reporting.ExampleApplication
{
    class test_with_bom_report : RazorTemplateBase
    {
        public override void Execute()
        {
            WriteLiteral(File.ReadAllText("../../test_with_bom.xrpt"));
        }
    }
}
