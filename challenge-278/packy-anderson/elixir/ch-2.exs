#!/usr/bin/env elixir

defmodule PWC do
  def reverseWord(str, char) do
    if String.contains?(str, char) do
      [part1, part2] = String.split(str, char, parts: 2)
      part1 = part1 <> char # put back the char from the split
      |> String.graphemes
      |> Enum.sort
      |> Enum.join
      Enum.join([part1, part2])
    else
      str
    end
  end

  def solution(str, char) do
    IO.puts("Input: $str = \"#{str}\", $char = \"#{char}\"")
    IO.puts("Output: \"" <> reverseWord(str, char) <> "\"" )
  end
end

IO.puts("Example 1:")
PWC.solution("challenge", "e")

IO.puts("\nExample 2:")
PWC.solution("programming", "a")

IO.puts("\nExample 3:")
PWC.solution("champion", "b")
