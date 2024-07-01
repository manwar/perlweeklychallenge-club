#!/usr/bin/env elixir

defmodule PWC do
  def brokenKeys(sentence, keys) do
    {:ok, reg} = Regex.compile("[" <> Enum.join(keys) <> "]", [:caseless])
    String.split(sentence)
    |> Enum.filter(fn word -> not Regex.match?(reg, word) end)
    |> Enum.count
    |> to_string
  end

  def solution(sentence, keys) do
    keysStr = "'" <> Enum.join(keys, "', '") <> "'"
    IO.puts("Input: $sentence = \"#{sentence}\", @keys = (#{keysStr})")
    IO.puts("Output: " <> brokenKeys(sentence, keys) )
  end
end

IO.puts("Example 1:")
PWC.solution("Perl Weekly Challenge", ["l", "a"])

IO.puts("\nExample 2:")
PWC.solution("Perl and Raku", ["a"])

IO.puts("\nExample 3:")
PWC.solution("Well done Team PWC", ["l", "o"])

IO.puts("\nExample 4:")
PWC.solution("The joys of polyglottism", ["T"])
