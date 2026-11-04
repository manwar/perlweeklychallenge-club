#!/usr/bin/env elixir

defmodule PWC do
  def divisible_average(arr) do
    qualifying = arr
    |> Enum.filter(& Bitwise.bor(rem(&1, 2), rem(&1, 3)) == 0)
    if length(qualifying) == 0, do: 0,
    else: round(Enum.sum(qualifying) / length(qualifying))
  end

  def solution(arr) do
    IO.puts("Input: @arr = (" <> Enum.join(arr, ", ") <> ")")
    IO.puts("Output: #{divisible_average(arr)}")
  end
end

IO.puts("Example 1")
PWC.solution([18, 5, 7, 11])

IO.puts("\nExample 2")
PWC.solution([6, 12, 18, 24, 30, 40])

IO.puts("\nExample 3")
PWC.solution([3, 9, 15, 21, 27])

IO.puts("\nExample 4")
PWC.solution([6, 12, 14, 20])

IO.puts("\nExample 5")
PWC.solution([6, 6, 6, 12, 12])
