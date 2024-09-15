namespace ch_1;

public static class Ch1
{
    public static void Main(string[] args)
    {
        const string quineString = """
           namespace ch_1;

           public static class Ch1
           {{
               public static void Main(string[] args)
               {{
                   const string quineString = {0}{0}{0} {1} {0}{0}{0};
                   var words = string.Format(quineString, (char)34, quineString)
                       .Trim().Split([' ', '\n', '\r', '\t'], StringSplitOptions.RemoveEmptyEntries);
                   var randomWord = words[Random.Shared.Next(words.Length)];
                   Console.WriteLine(randomWord);
               }}
           }}
       """;
        var words = string.Format(quineString, (char)34, quineString)
            .Trim().Split([' ', '\n', '\r', '\t'], StringSplitOptions.RemoveEmptyEntries);
        var randomWord = words[Random.Shared.Next(words.Length)];
        Console.WriteLine(randomWord);
    }
}