#!/usr/bin/env elixir

defmodule PWC do
  def twoDarray(ints, r, c) when length(ints) != r * c do
    {
      "Unable to create a two-dimensional array with " <>
      "#{r} rows and #{c} columns\nfrom a list of " <>
      "#{length(ints)} integers; there must be #{r * c} " <>
      "integers.",
      []
    }
  end

  def twoDarray(ints, _, c) do
    { nil, Enum.chunk_every(ints, c) }
  end

  # default value for indent
  def formatMatrix(matrix), do: formatMatrix(matrix, 8)

  def formatMatrix(matrix, indent) do
    output = for row <- matrix do
      String.duplicate(" ", indent) <> "  [" <>
      Enum.join(row, ", ") <> "]"
    end
    "[\n" <> Enum.join(output, ",\n") <> "\n" <>
    String.duplicate(" ", indent) <> "]"
  end

  def solution(ints, r, c) do
    int_list = "(" <> Enum.join(ints, ", ") <> ")"
    IO.puts("Input: @ints = #{int_list}, $r = #{r}, $c = #{c}")
    {err, arr} = twoDarray(ints, r, c)
    if err do
      IO.puts("\n#{err}")
    else
      IO.inspect(arr)
      IO.puts("Output: " <> formatMatrix(arr) )
    end
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 3, 4], 2, 2)

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3], 1, 3)

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 4], 4, 1)

IO.puts("\nExample 4:")
PWC.solution([1, 2, 3, 4], 3, 1)

IO.puts("\nExample 5:")
PWC.solution([1, 2, 3, 4], 3, 2)
