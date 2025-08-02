#!/usr/bin/env elixir

defmodule PWC do
  def bit_count(num) do
    binary = Integer.to_string(num, 2)
    String.length(Regex.replace(~r/0/, binary, ""))
  end

  def sortByHammingWeight(ints) do
    Enum.sort_by(ints, &{ bit_count(&1), &1 })
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    out = sortByHammingWeight(ints)
    IO.puts("Output: (" <> Enum.join(out, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([0, 1, 2, 3, 4, 5, 6, 7, 8])

IO.puts("\nExample 2:")
PWC.solution([1024, 512, 256, 128, 64])
