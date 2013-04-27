using System.IO;
using System.Text;

namespace crispin.Helpers
{
    internal class StringWriterWithEncoding : StringWriter
    {
        Encoding _encoding;

        public override Encoding Encoding { get { return _encoding; } }

        public StringWriterWithEncoding(Encoding encoding)
        {
            _encoding = encoding;
        }
    }
}
