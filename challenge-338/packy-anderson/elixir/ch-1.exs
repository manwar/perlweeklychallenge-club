#!/usr/bin/env elixir

defmodule PWC do
  def highest_row(matrix) do
    Enum.map(matrix, fn row -> Enum.sum(row) end) |> Enum.max
  end

  def solution(matrix) do
    m = Enum.map(matrix, fn row -> Enum.join(row, ", ") end)
    |> Enum.join(",\n                ")

    IO.puts("Input: @ints = (#{m})")
    IO.puts("Output: #{highest_row(matrix)}")
  end
end

IO.puts("Example 1:")
PWC.solution([[4,  4, 4, 4],
              [10, 0, 0, 0],
              [2,  2, 2, 9]])

IO.puts("\nExample 2:")
PWC.solution([[1, 5],
              [7, 3],
              [3, 5]])

IO.puts("\nExample 3:")
PWC.solution([[1, 2, 3],
             [3, 2, 1]])

IO.puts("\nExample 4:")
PWC.solution([[2, 8, 7],
              [7, 1, 3],
              [1, 9, 5]])

IO.puts("\nExample 5:")
PWC.solution([[10, 20,  30],
              [5,  5,   5],
              [0,  100, 0],
              [25, 25,  25]])
