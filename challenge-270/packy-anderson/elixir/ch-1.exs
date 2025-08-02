#!/usr/bin/env elixir

defmodule PWC do

  def sumRow(matrix, i) do
    matrix
    |> Enum.at(i)
    |> Enum.sum
  end

  def sumCol(matrix, j) do
    matrix
    |> Enum.map(fn x -> Enum.at(x, j) end)
    |> Enum.sum
  end

  def specialPositions(matrix) do
    special = []
    special = for i <- 0..length(matrix)-1 do
      row = Enum.at(matrix, i)
      for j <- 0..length(row)-1 do
        value = Enum.at(row, j)
        if value == 1 and
           sumRow(matrix, i) == 1 and
           sumCol(matrix, j) == 1 do
          # it's special
          special ++ [ "(#{i}, #{j})" ]
        else
          special
        end
      end
    end
    special = List.flatten(special)
    {
      length(special),
      case length(special) do
        1 -> "Special position is "
        _ -> "Special positions are "
      end <> Enum.join(special, ", ")
    }
  end

  # default value for indent
  def formatMatrix(matrix), do: formatMatrix(matrix, 17)

  def formatMatrix(matrix, indent) do
    output = for row <- matrix do
      String.duplicate(" ", indent) <> "  [" <>
      Enum.join(row, ", ") <> "]"
    end
    "[\n" <> Enum.join(output, ",\n") <> "\n" <>
    String.duplicate(" ", indent) <> "]"
  end

  def solution(matrix) do
    IO.puts("Input: $matrix = " <> formatMatrix(matrix))
    {count, explain} = PWC.specialPositions(matrix)
    IO.puts("Output: " <> to_string(count) )
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([
  [1,0,0],
  [0,0,1],
  [1,0,0]
])

IO.puts("\nExample 2:")
PWC.solution([
  [1,0,0],
  [0,1,0],
  [0,0,1]
])
