#!/usr/bin/env elixir

defmodule PWC do
  # list is empty, return results
  defp numberGame([], results) do
    results
  end

  # grab the first elem off list, recurse
  defp numberGame([x | rest], results) do
    numberGame(x, rest, results)
  end

  # grab second elem off list, swap them, recurse
  defp numberGame(x, [y | rest], results) do
    results = Enum.concat(results, [y, x])
    numberGame(rest, results)
  end

  # sort the list and then recursively swap element pairs
  def numberGame(ints) do
    sortedInts = Enum.sort(ints)
    numberGame(sortedInts, [])
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    result = PWC.numberGame(ints)
    IO.puts("Output: (" <> Enum.join(result, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 5, 3, 4])

IO.puts("\nExample 2:")
PWC.solution([9, 4, 1, 3, 6, 4, 6, 1])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 2, 3])
