#!/usr/bin/env elixir

defmodule PWC do
  def shift_right(array, k) when k <= 0, do: array

  def shift_right(array, k) do
    [head | tail] = Enum.reverse(array)
    shift_right([head | Enum.reverse(tail)], k-1)
  end

  def shift_grid(matrix, k) do
    # get the width of the matrix
    n = length(hd(matrix))

    # flatten the matrix
    flat = Enum.flat_map(matrix, fn x -> x end)

    # shift to the right
    flat = shift_right(flat, k)

    # re-matrix the array
    Enum.chunk_every(flat, n)
  end

  def format_matrix(grid, indent \\ 19) do
    grid
    |> Enum.map(fn row -> Enum.join(row, ", ") end)
    |> Enum.map(fn row -> "[" <> row <> "]" end)
    |> Enum.join(",\n" <> String.duplicate(" ", indent))
  end

  def solution(matrix, k) do
    IO.puts("Input: @matrix = [ #{format_matrix(matrix)} ]")
    IO.puts("       $k = #{k}")
    output = shift_grid(matrix, k)
    IO.puts("Output: [ #{format_matrix(output, 10)} ]")
  end
end

IO.puts("Example 1:")
PWC.solution([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]], 1)

IO.puts("\nExample 2:")
PWC.solution([[10, 20],
              [30, 40]], 1)

IO.puts("\nExample 3:")
PWC.solution([[1, 2],
              [3, 4],
              [5, 6]], 1)

IO.puts("\nExample 4:")
PWC.solution([[1, 2, 3],
              [4, 5, 6]], 5)

IO.puts("\nExample 5:")
PWC.solution([[1, 2, 3, 4]], 1)
