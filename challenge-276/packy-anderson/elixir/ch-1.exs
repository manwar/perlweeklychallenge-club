#!/usr/bin/env elixir

defmodule PWC do
  def makePair([], _, pairs), do: pairs
  def makePair([j], i, pairs) do
    pairs ++ [ [i, j] ]
  end
  def makePair([j | rest], i, pairs) do
    pairs = pairs ++ [ [i, j] ]
    makePair(rest, i, pairs)
  end

  def findPairs([], pairs), do: pairs
  def findPairs([i | rest], pairs) do
    canPair = Enum.filter(rest, fn j -> rem(i + j, 24) == 0 end)
    pairs = makePair(canPair, i, pairs)
    findPairs(rest, pairs)
  end

  def explainPairs([], _, explain), do: explain
  def explainPairs([pair | rest ], i, explain) do
    pairList = "(" <> Enum.join(pair, ", ") <> ")"
    pairNum  = "Pair #{to_string(i)}: "
    explainPairs(rest, i+1, explain <> "\n" <> pairNum <> pairList)
  end

  def completeDays(hours) do
    pairs = findPairs(hours, [])
    explain = explainPairs(pairs, 1, "")
    {length(pairs), explain}
  end

  def solution(hours) do
    IO.puts("Input: @hours = (" <> Enum.join(hours, ", ") <> ")")
    {count, explain} = completeDays(hours)
    IO.puts("Output: " <> to_string(count) )
    IO.puts(explain)
  end
end

IO.puts("Example 1:")
PWC.solution([12, 12, 30, 24, 24])

IO.puts("\nExample 2:")
PWC.solution([72, 48, 24, 5])

IO.puts("\nExample 3:")
PWC.solution([12, 18, 24])
