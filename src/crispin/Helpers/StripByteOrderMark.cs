namespace crispin.Helpers
{
    class StripByteOrderMark
    {
        public static string Strip(string input)
        {
            return input
                .Trim()
                .Trim(new char[]{
                    '\uFEFF',
                    '\u200B'
                });
        }
    }
}
