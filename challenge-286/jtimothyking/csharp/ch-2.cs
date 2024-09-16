namespace ch_2;

public static class Ch2
{
    public static void Main(string[] args)
    {
        var ints = args.Select(int.Parse).ToList();
        if (ints.Count < 1) return;
        while (ints.Count > 1) ints = ints.MinMax().ToList();
        Console.WriteLine(ints[0]);
    }

    private static IEnumerable<int> MinMax(this IEnumerable<int> ints)
    {
        var doMin = true;
        foreach (var pair in ints.Chunk(2))
        {
            yield return doMin ? pair.Min() : pair.Max();
            doMin = !doMin;
        }
    }
}