#!/usr/bin/env elixir

defmodule PWC do
  def compute(ints, x) do
    num = ints
    |> Enum.join
    |> String.to_integer
    num + x
    |> Integer.to_string
    |> String.graphemes
  end

  def solution(ints, x) do
    joined = Enum.join(ints, ", ")
    IO.puts("Input: @ints = (#{joined}), $x = #{x}")
    joined = Enum.join(compute(ints, x), ", ")
    IO.puts("Output: (#{joined})")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 3, 4], 12)

IO.puts("\nExample 2:")
PWC.solution([2, 7, 4], 181)

IO.puts("\nExample 3:")
PWC.solution([9, 9, 9], 1)

IO.puts("\nExample 4:")
PWC.solution([1, 0, 0, 0, 0], 9999)

IO.puts("\nExample 5:")
PWC.solution([0], 1000)
