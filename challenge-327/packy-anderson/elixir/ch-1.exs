#!/usr/bin/env elixir

defmodule PWC do
  defp map_reduce_func(i, {set, missing}) do
    {i,
      if not MapSet.member?(set, i) do
        {set, missing ++ [i]}
      else
        {set, missing}
      end
    }
  end

  def missingInts(ints) do
    {_, {_, missing}} =
      1..length(ints)
      |> Enum.map_reduce(
           { MapSet.new(ints), [] },
           &map_reduce_func/2
         )
    missing
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    missing = missingInts(ints)
    IO.puts("Output: (" <> Enum.join(missing, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 1, 3, 2, 5])

IO.puts("\nExample 2:")
PWC.solution([1, 1, 1])

IO.puts("\nExample 3:")
PWC.solution([2, 2, 1])
