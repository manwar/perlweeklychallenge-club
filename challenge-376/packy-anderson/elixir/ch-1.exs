#!/usr/bin/env elixir

defmodule PWC do
  require Integer

  def is_black(c) do
    col = String.at(c, 0) |> String.match?(~r/[aceg]/)
    row = String.at(c, 1) |> String.to_integer |> Integer.is_odd
    if (col && row) || (!col && !row), do: true, else: false
  end

  def chessboard_squares(c1, c2) do
    if is_black(c1) == is_black(c2), do: "true", else: "false"
  end

  def solution(c1, c2) do
    IO.puts("Input: $c1 = \"#{c1}\", $c2 = \"#{c2}\"")
    IO.puts("Output: #{chessboard_squares(c1, c2)}")
  end
end

IO.puts("Example 1:")
PWC.solution("a7", "f4")

IO.puts("\nExample 2:")
PWC.solution("c1", "e8")

IO.puts("\nExample 3:")
PWC.solution("b5", "h2")

IO.puts("\nExample 4:")
PWC.solution("f3", "h1")

IO.puts("\nExample 5:")
PWC.solution("a1", "g8")
