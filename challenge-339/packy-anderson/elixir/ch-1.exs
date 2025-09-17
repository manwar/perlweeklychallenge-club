#!/usr/bin/env elixir

defmodule PWC do
  def max_diff(ints) do
    ints = Enum.sort(ints, &(abs(&1) <= abs(&2)))
    {a, b} = {Enum.at(ints,  0), Enum.at(ints,  1)}
    {c, d} = {Enum.at(ints, -2), Enum.at(ints, -1)}
    abs((a * b) - (c * d))
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{max_diff(ints)}")
  end
end

IO.puts("Example 1:")
PWC.solution([5, 9, 3, 4, 6])

IO.puts("\nExample 2:")
PWC.solution([1, -2, 3, -4])

IO.puts("\nExample 3:")
PWC.solution([-3, -1, -2, -4])

IO.puts("\nExample 4:")
PWC.solution([10, 2, 0, 5, 1])

IO.puts("\nExample 5:")
PWC.solution([7, 8, 9, 10, 10])
