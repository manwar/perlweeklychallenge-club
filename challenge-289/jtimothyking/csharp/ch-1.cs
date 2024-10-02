namespace ch_1;

public static class Ch1
{
    public static void Main(string[] args)
    {
        var firstThree = args.Select(int.Parse)
            .OrderDescending().Distinct()
            .Take(3).ToArray();
        Console.WriteLine(
            firstThree.Length >= 3 ? firstThree[2] :
            firstThree.Length > 0 ? firstThree[0] :
            ""
        );
    }

    private static IEnumerable<T> Distinct<T>(this IOrderedEnumerable<T> source)
    {
        using var enumerator = source.GetEnumerator();
        if (!enumerator.MoveNext()) yield break;
        var comparer = EqualityComparer<T>.Default;
        var current = enumerator.Current;
        yield return current;
        while (enumerator.MoveNext())
        {
            var next = enumerator.Current;
            if (comparer.Equals(current, next)) continue;
            current = next;
            yield return current;
        }
    }
}