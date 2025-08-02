#!/usr/bin/env elixir

defmodule PWC do
  require Integer
  def splitString(str) do
    str
    |> String.downcase
    |> String.graphemes
    |> Enum.filter(&( String.match?(&1, ~r/[aeiou]/) ))
    |> Kernel.length
    |> Integer.is_even
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> to_string(splitString(str)) )
  end
end

IO.puts("Example 1:")
PWC.solution("perl")

IO.puts("\nExample 2:")
PWC.solution("book")

IO.puts("\nExample 3:")
PWC.solution("good morning")
