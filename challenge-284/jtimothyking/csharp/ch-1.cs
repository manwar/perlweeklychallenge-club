using PwcLib;

namespace _1_lucky_integer;

public static class LuckyInteger
{
    public static void Main(string[] args)
    {
        var input = Console.ReadLine() ?? "";
        var luckyInteger = input.GetInts().FindLargestLuckyInteger();
        Console.WriteLine(luckyInteger);
    }

    private static int FindLargestLuckyInteger(this int[] ints) =>
        ints
            .GroupBy(x => x)
            .Where(grouping => grouping.Count() == grouping.Key)
            .Select(grouping => grouping.Key)
            .OrderByDescending(x => x)
            .FirstOrDefault(defaultValue: -1);
}