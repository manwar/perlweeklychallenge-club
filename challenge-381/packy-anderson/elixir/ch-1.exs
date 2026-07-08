#!/usr/bin/env elixir

defmodule PWC do
  def has_all_num(n, elems) when length(elems) != n, do: false

  def has_all_num(n, elems), do:
    Enum.reduce(1..n, true, fn i,result ->
      result and Enum.any?(elems, &(&1 == i))
    end)

  def same_row_column(matrix) do
    n = length(matrix)
    # check rows
    Enum.reduce(matrix, true, fn row, result ->
      result and has_all_num(n, row)
    end)
    |> then(&(
      # check columns
      Enum.reduce(Enum.zip(matrix), &1, fn col, result ->
        result and has_all_num(n, Tuple.to_list(col))
      end)
    ))
  end

  def format_matrix(grid, indent \\ 19) do
    grid
    |> Enum.map(fn row -> Enum.join(row, ", ") end)
    |> Enum.map(fn row -> "[" <> row <> "]" end)
    |> Enum.join(",\n" <> String.duplicate(" ", indent))
  end
  def solution(matrix) do
    IO.puts("Input: @matrix = [")
    IO.puts("                   #{format_matrix(matrix)}")
    IO.puts("                 ]")
    IO.puts("Output: #{if same_row_column(matrix), do: "True", else: "False"}")
  end
end

IO.puts("Example 1:")
PWC.solution([
  [1, 2, 3, 4],
  [2, 3, 4, 1],
  [3, 4, 1, 2],
  [4, 1, 2, 3]
])

IO.puts("\nExample 2:")
PWC.solution([[1],])

IO.puts("\nExample 3:")
PWC.solution([
  [1, 2, 5],
  [5, 1, 2],
  [2, 5, 1]
])

IO.puts("\nExample 4:")
PWC.solution([
  [1, 2, 3],
  [1, 2, 3],
  [1, 2, 3]
])

IO.puts("\nExample 5:")
PWC.solution([
  [1, 2, 3],
  [3, 1, 2],
  [3, 2, 1]
])
