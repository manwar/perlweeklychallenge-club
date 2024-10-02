namespace ch_1;

public static class Ch1
{
    public static void Main(string[] args)
    {
        // Call whichever implementation you'd like to use.
        PrintThirdMax_impl2(args);
    }

    private static void PrintThirdMax_impl1(string[] args)
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

    private static void PrintThirdMax_impl2(string[] args)
    {
        var firstThree = args.Select(int.Parse).Max3().ToArray();
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

    /// <summary>Return the top 3 unique maximum integers in O(n) time.</summary>
    private static IEnumerable<T> Max3<T>(this IEnumerable<T> source)
    {
        const int numMaxValues = 3;
        var comparer = Comparer<T>.Default;
        var maxValues = new List<T>();
        foreach (var value in source) InsertIfNewMax(value);
        return maxValues;

        void InsertIfNewMax(T value)
        {
            for (var i = 0; i < numMaxValues; i++)
            {
                if (i < maxValues.Count && comparer.Compare(value, maxValues[i]) == 0) break;
                if (i < maxValues.Count && comparer.Compare(value, maxValues[i]) <= 0) continue;
                maxValues.Insert(i, value);
                if (maxValues.Count > numMaxValues) maxValues.RemoveAt(numMaxValues);
                break;
            }
        }
    }
}