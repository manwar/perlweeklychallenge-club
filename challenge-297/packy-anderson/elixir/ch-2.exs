#!/usr/bin/env elixir

defmodule PWC do
  def sop(ints) do
    n = length(ints)
    pos_one = Enum.find_index(ints, fn x -> x == 1 end)
    pos_n   = Enum.find_index(ints, fn x -> x == n end)
    cond do
      pos_one < pos_n -> pos_one + (n-1) - pos_n
      true            -> pos_one + (n-1) - pos_n - 1
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{sop(ints)}")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 1, 4, 3])

IO.puts("\nExample 2:")
PWC.solution([2, 4, 1, 3])

IO.puts("\nExample 3:")
PWC.solution([1, 3, 2, 4, 5])

IO.puts("\nExample 4:")
PWC.solution([5, 4, 3, 2, 1])

IO.puts("\nExample 5:")
PWC.solution([3, 1, 6, 4, 5, 7, 2])
