#!/usr/bin/env elixir

defmodule PWC do
  def merge([], arr2, merged), do: merged ++ arr2
  def merge(arr1, [], merged), do: merged ++ arr1
  def merge([v1 | arr1], [v2 | arr2], merged) do
    if v1 < v2 do
      merge(arr1, [v2] ++ arr2, merged ++ [v1])
    else
      merge([v1] ++ arr1, arr2, merged ++ [v2])
    end
  end

  def array_median(arr1, arr2) do
    merged = merge(arr1, arr2, [])
    len = length(merged)
    if rem(len, 2) == 1 do
      Enum.at(merged, div(len, 2)) / 1
    else
      mid = div(len, 2) - 1
      (Enum.at(merged, mid) + Enum.at(merged, mid+1)) / 2
    end
  end

  def solution(arr1, arr2) do
    IO.puts("Input: @arr1 = (" <> Enum.join(arr1, ", ") <>
            "), @arr2 = (" <> Enum.join(arr2, ", ") <> ")")
    IO.puts("Output: #{array_median(arr1, arr2)}")
  end
end

IO.puts("Example 1:")
PWC.solution([2],[4])

IO.puts("\nExample 2:")
PWC.solution([1,2,3],[7,8,9,10])

IO.puts("\nExample 3:")
PWC.solution([],[10,20,30,40])

IO.puts("\nExample 4:")
PWC.solution([100],[1,2,3,4,5,6,7])

IO.puts("\nExample 5:")
PWC.solution([1,2,2],[2,2,3])
