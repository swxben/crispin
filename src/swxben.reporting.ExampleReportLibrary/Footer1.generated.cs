﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18010
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace swxben.reporting.ExampleReportLibrary
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("RazorGenerator", "1.5.0.0")]
    public partial class Footer1 : RazorGenerator.Templating.RazorTemplateBase
    {
#line hidden

        public override void Execute()
        {


WriteLiteral(@"

<footer>
    <div>
        <hr />
        <table>
            <col width=""50%"" />
            <col width=""50%"" />
            <tbody>
                <tr>
                    <td align=""left"">
                        <h4>swxben.reporting</h4>
                    </td>
                    <td align=""right"">
                        <p><small>Generated ");


            
            #line 15 "..\..\Footer1.cshtml"
                                       Write(DateTime.Now.ToString("HH:mm:ss - dd/MM/yyyy"));

            
            #line default
            #line hidden
WriteLiteral("</small></p>\r\n                    </td>\r\n                </tr>\r\n            </tbo" +
"dy>\r\n        </table>\r\n    </div>\r\n</footer>\r\n");


        }
    }
}
#pragma warning restore 1591
