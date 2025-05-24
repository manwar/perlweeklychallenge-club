#!/usr/bin/env elixir

defmodule PWC do
  def strFormat(charlist, i, output) when length(charlist) <= i,
    do: List.to_string(charlist) <> output

  def strFormat(charlist, i, output) do
    chunk    = Enum.take(charlist, -i) |> List.to_string
    charlist = Enum.take(charlist, length(charlist)-i)
    strFormat(charlist, i, "-" <> chunk <> output)
  end

  def strFormat(str, i) do
    str = String.replace(str, "-", "")
    strFormat(String.graphemes(str), i, "")
  end

  def solution(str, i) do
    IO.puts("Input: $str = \"#{str}\", $i = #{i}")
    IO.puts("Output: \"#{strFormat(str, i)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("ABC-D-E-F", 3)

IO.puts("\nExample 2:")
PWC.solution("A-BC-D-E", 2)

IO.puts("\nExample 3:")
PWC.solution("-A-B-CD-E", 4)

IO.puts("\nExample 4:")
PWC.solution("-A-B-CD-E", 5)
