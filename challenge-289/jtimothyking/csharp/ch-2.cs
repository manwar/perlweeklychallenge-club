using System.Text.RegularExpressions;

namespace ch_2;

public static class Ch2
{
    public static void Main()
    {
        while (Console.ReadLine() is { } line)
            foreach (var outputWord in Regex.Split($"{line}\n", @"\b").Select(Jumble))
                Console.Write(outputWord);
    }

    private static string Jumble(string word) =>
        word.Length < 4 || !Regex.IsMatch(word, @"\w")
            ? word
            : word[0] + word[1..^1].Shuffle() + word[^1];

    private static string Shuffle(this string str)
    {
        var chars = str.ToCharArray();
        Random.Shared.Shuffle(chars);
        return new string(chars);
    }
}