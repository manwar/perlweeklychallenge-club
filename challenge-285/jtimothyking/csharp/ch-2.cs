using System.Collections.Concurrent;

namespace _2_making_change;

public static class MakingChange
{
    private static readonly int[] Coins = [1, 5, 10, 25, 50];
    private static readonly ConcurrentDictionary<ChangeKey, Task<int>> NumWaysTasks = new();

    public static async Task Main()
    {
        var amount = int.Parse(await Console.In.ReadLineAsync() ?? "");
        var numWays = await GetNumWaysToMakeChangeAsync(amount);
        Console.WriteLine(numWays);
    }

    private static Task<int> GetNumWaysToMakeChangeAsync(int amount) =>
        GetNumWaysToMakeChangeAsync(amount, Coins.Length);

    private static Task<int> GetNumWaysToMakeChangeAsync(int amount, int numCoins)
    {
        // Calculate the number of ways to make change using recursion.

        // Parallelize and memoize by storing a task for each recursive call.
        // Each call to CalculateAsync creates a new task, which is executed in a
        // worker thread managed by the .NET thread pool. This task is stored in
        // the NumWays concurrent dictionary, and awaiting it returns the result.
        return NumWaysTasks.GetOrAdd(new ChangeKey(amount, numCoins), CalculateAsync);

        async Task<int> CalculateAsync(ChangeKey key)
        {
            if (key.Amount == 0) return 1;
            if (key.Amount < 0 || key.NumCoins == 0) return 0;
            // Execute the recursive calls in parallel.
            var useCoinTask = GetNumWaysToMakeChangeAsync(key.Amount - Coins[key.NumCoins - 1], key.NumCoins);
            var skipCoinTask = GetNumWaysToMakeChangeAsync(key.Amount, key.NumCoins - 1);
            return await useCoinTask + await skipCoinTask;
        }
    }

    private record struct ChangeKey(int Amount, int NumCoins);
}