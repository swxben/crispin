using java.io;
using javax.xml.transform.sax;
using javax.xml.transform.stream;
using org.apache.fop.apps;

namespace crispin.Helpers
{
    public static class FopInterface
    {
        static readonly FopFactory FopFactory;

        static FopInterface()
        {
            FopFactory = FopFactory.newInstance(new File(".").toURI());
        }

        public static byte[] ProcessXslFo(string xslfo, string name)
        {
            var foUserAgent = FopFactory.newFOUserAgent();
            foUserAgent.setCreator("Crispin (Apache FOP 2.1 via IKVM)");
            foUserAgent.setTitle(name);

            var outputStream = new java.io.ByteArrayOutputStream();

            var fop = FopFactory.newFop(org.apache.xmlgraphics.util.MimeConstants.__Fields.MIME_PDF, foUserAgent, outputStream);

            var transformerFactory = new com.sun.org.apache.xalan.@internal.xsltc.trax.TransformerFactoryImpl();
            var transformer = transformerFactory.newTransformer();

            var source = new StreamSource(new java.io.StringReader(xslfo));

            var result = new SAXResult(fop.getDefaultHandler());

            transformer.transform(source, result);

            /*
             * Adding the page count requires a second pass. This should be configurable
             * by the report itself.
             * */
            /*
            transformer.setParameter("page-count", fop.getResults().getPageCount().ToString());
            transformer.transform(src, res);
             * */

            outputStream.close();

            return outputStream.toByteArray();
        }
    }
}
