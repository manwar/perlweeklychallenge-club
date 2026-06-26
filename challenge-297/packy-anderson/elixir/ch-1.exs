#!/usr/bin/env elixir

defmodule PWC do
  def contiguous_array(arr) do
    len = length(arr)
    sum = Enum.sum(arr)
    cond do
      # special case: all 0s or all 1s
      sum == 0 or sum == len -> 0
      # special case: entire array is equal
      sum == len/2 -> len
      # generate subarrays and check
      true ->
        Enum.reduce(0 .. len-2, 0, fn i, max ->
          Enum.reduce(i+1 .. len-1, max, fn j, max ->
            subarr = Enum.slice(arr, i..j)
            sublen = length(subarr)
            if Enum.sum(subarr) == sublen/2, do:
              Enum.max([max, sublen]), else: max
          end)
        end)
    end
  end

  def solution(arr) do
    IO.puts("Input: @arr = (" <> Enum.join(arr, ", ") <> ")")
    IO.puts("Output: #{contiguous_array(arr)}")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 0])

IO.puts("\nExample 2:")
PWC.solution([0, 1, 0])

IO.puts("\nExample 3:")
PWC.solution([0, 0, 0, 0, 0])

IO.puts("\nExample 4:")
PWC.solution([0, 1, 0, 0, 1, 0])

IO.puts("\nExample 5:")
PWC.solution([1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1])
