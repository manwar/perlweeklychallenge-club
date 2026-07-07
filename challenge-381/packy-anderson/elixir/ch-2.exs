#!/usr/bin/env elixir

defmodule PWC do
  # not enough unique elements
  defp smaller_greater(_, keys) when length(keys) < 3, do: 0

  defp smaller_greater(bag, keys) do
    {{min, max} = {Enum.min(keys), Enum.max(keys)}}
    # drop the smallest and the greatest
    Map.drop(bag, [min, max])
    |> Map.values |> Enum.sum
  end

  def smaller_greater(int) do
    bag = Enum.frequencies(int)
    smaller_greater(bag, Map.keys(bag))
  end

  def solution(int) do
    IO.puts("Input: @int = (" <> Enum.join(int, ", ") <> ")")
    IO.puts("Output: #{smaller_greater(int)}")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 4])

IO.puts("\nExample 2:")
PWC.solution([1, 1, 1, 1])

IO.puts("\nExample 3:")
PWC.solution([1, 1, 4, 8, 12, 12])

IO.puts("\nExample 4:")
PWC.solution([3, 6, 6, 9])

IO.puts("\nExample 5:")
PWC.solution([0, -5, 10, -2, 4])
