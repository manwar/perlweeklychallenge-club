namespace ch_1;

public static class Ch1
{
    public static void Main(string[] args)
    {
        var ints = args.Select(int.Parse).ToArray();
        var middleIndex = ints.LeftRightSums()
            .Select((sums, idx) => (sums, idx))
            .FirstOrDefault(x => x.sums.leftSum == x.sums.rightSum,
                defaultValue: (sums: (leftSum: 0, rightSum: 0), idx: -1))
            .idx;
        Console.WriteLine(middleIndex);
    }

    private static IEnumerable<(int leftSum, int rightSum)> LeftRightSums(this int[] ints)
    {
        var totalSum = ints.Sum();
        var leftSum = 0;
        foreach (var item in ints)
        {
            var rightSum = totalSum - leftSum - item;
            yield return (leftSum, rightSum);
            leftSum += item;
        }
    }
}