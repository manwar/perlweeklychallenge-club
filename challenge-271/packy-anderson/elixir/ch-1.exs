#!/usr/bin/env elixir

defmodule PWC do
  # we've exhasuted the matrix, return maxRow as 1-indexed value
  def maximumOnes([], _, _, maxRow), do: maxRow + 1

  def maximumOnes([row | matrix], rowNum, maxCount, maxRow) do
    count = Enum.sum(row)
    if count > maxCount do
      # make the recursive call with this count and rowNum
      maximumOnes(matrix, rowNum+1, count, rowNum)
    else
      # make the recursive call with the count and rowNum
      # it was called with
      maximumOnes(matrix, rowNum+1, maxCount, maxRow)
    end
  end

  def maximumOnes(matrix) do
    # set up the loop with initial values
    maximumOnes(matrix, 0, -1, -1)
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
    IO.puts("Output: " <> to_string(maximumOnes(matrix)))
  end
end

IO.puts("Example 1:")
PWC.solution([ [0, 1],
               [1, 0] ])

IO.puts("\nExample 2:")
PWC.solution([ [0, 0, 0],
               [1, 0, 1] ])

IO.puts("\nExample 3:")
PWC.solution([ [0, 0],
               [1, 1],
               [0, 0] ])
