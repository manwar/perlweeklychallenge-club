#!/usr/bin/env elixir

defmodule PWC do
  def count_prefixes(string, array) do
    array
    |> Enum.filter(fn s -> String.starts_with?(string, s) end)
    |> length
  end

  def solution(string, array) do
    strlist = array
    |> Enum.map(fn s -> "\"#{s}\"" end)
    |> Enum.join(", ")
    IO.puts("Input: @array = (#{strlist}), $str = \"#{string}\"")
    IO.puts("Output: #{count_prefixes(string, array)}")
  end
end

IO.puts("Example 1:")
PWC.solution("apple", ["a", "ap", "app", "apple", "banana"])

IO.puts("\nExample 2:")
PWC.solution("bird", ["cat", "dog", "fish"])

IO.puts("\nExample 3:")
PWC.solution("hello", ["hello", "he", "hell", "heaven", "he"])

IO.puts("\nExample 4:")
PWC.solution("coding", ["", "code", "coding", "cod"])

IO.puts("\nExample 5:")
PWC.solution("program", ["p", "pr", "pro", "prog", "progr", "progra", "program"])
