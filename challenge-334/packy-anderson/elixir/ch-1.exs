#!/usr/bin/env elixir

defmodule PWC do
  def range_sum(ints, x, y) do
    Enum.slice(ints, x..y) |> Enum.sum
  end

  def solution(ints, x, y) do
    int_list = Enum.join(ints, ", ")
    IO.puts("Input: @ints = (#{int_list}), $x = #{x}, $y = #{y}")
    IO.puts("Output: #{range_sum(ints, x, y)}")
  end
end

IO.puts("Example 1:")
PWC.solution([-2, 0, 3, -5, 2, -1], 0, 2)

IO.puts("\nExample 2:")
PWC.solution([1, -2, 3, -4, 5], 1, 3)

IO.puts("\nExample 3:")
PWC.solution([1, 0, 2, -1, 3], 3, 4)

IO.puts("\nExample 4:")
PWC.solution([-5, 4, -3, 2, -1, 0], 0, 3)

IO.puts("\nExample 5:")
PWC.solution([-1, 0, 2, -3, -2, 1], 0, 2)
