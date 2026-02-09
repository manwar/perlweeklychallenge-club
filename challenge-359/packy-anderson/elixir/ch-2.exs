#!/usr/bin/env elixir

defmodule PWC do
  def string_reduction(word) do
    replaced = Regex.replace(~r/(.)\1/, word, "")
    cond do
      replaced == word -> replaced
      true -> string_reduction(replaced)
    end
  end

  def solution(word) do
    IO.puts("Input: $word = \"#{word}\"")
    IO.puts("Output: \"#{string_reduction(word)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("aabbccdd")

IO.puts("\nExample 2:")
PWC.solution("abccba")

IO.puts("\nExample 3:")
PWC.solution("abcdef")

IO.puts("\nExample 4:")
PWC.solution("aabbaeaccdd")

IO.puts("\nExample 5:")
PWC.solution("mississippi")
