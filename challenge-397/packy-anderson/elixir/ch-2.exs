#!/usr/bin/env elixir

defmodule PWC do
  def sort_by_binary_reflection(arr) do
    Enum.sort_by(arr, &(
      &1
      |> Integer.digits(2)
      |> Enum.reverse
      |> Enum.join
      |> String.to_integer(2)
    ))
  end

  def solution(arr) do
    IO.puts("Input: @arr = (" <> Enum.join(arr, ", ") <> ")")
    IO.puts("Output: (" <> Enum.join(sort_by_binary_reflection(arr), ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([3, 6, 12])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 4, 8])

IO.puts("\nExample 3:")
PWC.solution([7, 8, 9, 10])

IO.puts("\nExample 4:")
PWC.solution([5, 9, 15, 17])

IO.puts("\nExample 5:")
PWC.solution([11, 13, 14, 19])
