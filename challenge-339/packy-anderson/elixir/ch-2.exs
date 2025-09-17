#!/usr/bin/env elixir

defmodule PWC do
  def add_max(x, {sum, max}) do
    sum = sum + x
    max = Enum.max([max, sum])
    { x, {sum, max} }
  end

  def peak_point(gain) do
    {_, {_, max}} = Enum.map_reduce(gain, {0, 0}, &add_max/2)
    max
  end

  def solution(gain) do
    IO.puts("Input: @gain = (" <> Enum.join(gain, ", ") <> ")")
    IO.puts("Output: #{peak_point(gain)}")
  end
end

IO.puts("Example 1:")
PWC.solution([-5, 1, 5, -9, 2])

IO.puts("\nExample 2:")
PWC.solution([10, 10, 10, -25])

IO.puts("\nExample 3:")
PWC.solution([3, -4, 2, 5, -6, 1])

IO.puts("\nExample 4:")
PWC.solution([-1, -2, -3, -4])

IO.puts("\nExample 5:")
PWC.solution([-10, 15, 5])
