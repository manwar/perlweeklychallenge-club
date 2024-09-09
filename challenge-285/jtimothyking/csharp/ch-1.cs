namespace _1_no_connection;

public static class NoConnection
{
    public static async Task Main()
    {
        // Read the input, a series of lines in the format "start end", followed by a blank line.
        var connections = await Console.In.ReadLinesAsync()
            .TakeWhile(line => !string.IsNullOrWhiteSpace(line))
            .Select(line => line.Trim().Split(' ', 2, StringSplitOptions.RemoveEmptyEntries))
            .Select(parts => (start: parts[0], end: parts[1]))
            .ToListAsync();

        var startPoints = connections.Select(connection => connection.start).ToHashSet();
        var unconnectedEndpoints = connections.Select(connection => connection.end)
            .Where(endpoint => !startPoints.Contains(endpoint))
            .ToHashSet();
        foreach (var endpoint in unconnectedEndpoints.Order())
            Console.WriteLine(endpoint);
    }

    private static async IAsyncEnumerable<string> ReadLinesAsync(this TextReader reader)
    {
        while (await reader.ReadLineAsync() is { } line)
            yield return line;
    }
}