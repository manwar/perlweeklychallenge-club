#!/usr/bin/env elixir

defmodule PWC do
  def max_distance(arr1, arr2) do
    {min1, max1} = {Enum.min(arr1), Enum.max(arr1)}
    {min2, max2} = {Enum.min(arr2), Enum.max(arr2)}
    Enum.max([abs(max1 - min2), abs(max2 - min1)])
  end

  def solution(arr1, arr2) do
    IO.puts("Input: @arr1 = (" <> Enum.join(arr1, ", ") <> ")")
    IO.puts("       @arr2 = (" <> Enum.join(arr2, ", ") <> ")")
    IO.puts("Output: #{max_distance(arr1, arr2)}")
  end
end

IO.puts("Example 1:")
PWC.solution([4, 5, 7], [9, 1, 3, 4])

IO.puts("\nExample 2:")
PWC.solution([2, 3, 5, 4], [3, 2, 5, 5, 8, 7])

IO.puts("\nExample 3:")
PWC.solution([2, 1, 11, 3], [2, 5, 10, 2])

IO.puts("\nExample 4:")
PWC.solution([1, 2, 3], [3, 2, 1])

IO.puts("\nExample 5:")
PWC.solution([1, 0, 2, 3], [5, 0])
