using System.Text.RegularExpressions;

namespace PwcLib;

public static class InputParsingExtensions
{
    /// <summary>
    ///    Parses a line of the form "@<symbol> = (1, 2, 3)" into an array of integers.
    /// </summary>
    public static int[] GetInts(this string line, string symbol = "ints")
    {
        var match = Regex.Match(line, $@"
            \A \s*
            \@{symbol} \s* = \s* \(
                ( \d+ (?: \s* , \s* \d+ )* )
            \)
            \s* \z
        ", RegexOptions.IgnorePatternWhitespace);
        if (!match.Success)
            throw new ArgumentException($"Invalid input: {line}", nameof(line));
        return match.Groups[1].Value.Split(", ").Select(int.Parse).ToArray();
    }
}