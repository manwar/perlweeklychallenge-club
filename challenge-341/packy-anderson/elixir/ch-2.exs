#!/usr/bin/env elixir

defmodule PWC do
  def reverse_prefix(str, char) do
    [a, b] = String.split(str, char, parts: 2)
    char <> String.reverse(a) <> b
  end

  def solution(str, char) do
    IO.puts("Input: $str = \"#{str}\", $char = \"#{char}\"")
    IO.puts("Output: \"#{reverse_prefix(str, char)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("programming", "g")

IO.puts("\nExample 2:")
PWC.solution("hello", "h")

IO.puts("\nExample 3:")
PWC.solution("abcdefghij", "h")

IO.puts("\nExample 4:")
PWC.solution("reverse", "s")

IO.puts("\nExample 5:")
PWC.solution("perl","r")
