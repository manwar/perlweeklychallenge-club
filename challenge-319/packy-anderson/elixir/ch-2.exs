#!/usr/bin/env elixir

defmodule PWC do
  def minCommon(arr1, arr2) do
    set1   = MapSet.new(arr1)
    set2   = MapSet.new(arr2)
    common = MapSet.intersection(set1, set2)
    cond do
      MapSet.size(common) == 0 -> -1
      true -> common |> MapSet.to_list |> Enum.min
    end
  end

  def solution(arr1, arr2) do
    IO.puts("Input: @array_1 = (" <> Enum.join(arr1, ", ") <> ")")
    IO.puts("       @array_2 = (" <> Enum.join(arr2, ", ") <> ")")
    IO.puts("Output: " <> to_string( minCommon(arr1, arr2) ) )
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 3, 4], [3, 4, 5, 6])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3], [2, 4])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 4], [5, 6, 7, 8])
