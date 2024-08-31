using PwcLib;

namespace _2_relative_sort;

public static class RelativeSort
{
    public static void Main(string[] args)
    {
        var line1 = Console.ReadLine() ?? "";
        var line2 = Console.ReadLine() ?? "";
        var sortedInts = line1.GetInts("list1")
            .OrderRelativeTo(line2.GetInts("list2"));
        Console.WriteLine($"({string.Join(", ", sortedInts)})");
    }

    /// <summary>
    ///    Orders the elements of the source list relative to the order of the reference list.
    /// </summary>
    private static int[] OrderRelativeTo(this IEnumerable<int> source, IEnumerable<int> reference)
    {
        var rank = reference.ToRankDictionary();
        return source
            .OrderBy(x => rank.GetValueOrDefault(x, defaultValue: x + rank.Count))
            .ToArray();
    }

    /// <summary>
    ///     Returns a dictionary that maps each element of the source to its index in the source.
    /// </summary>
    private static Dictionary<TSource, int> ToRankDictionary<TSource>(this IEnumerable<TSource> source)
        where TSource : notnull =>
        source.Select((x, i) => (x, i)).ToDictionary(xi => xi.x, xi => xi.i);
}