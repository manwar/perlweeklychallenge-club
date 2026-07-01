#!/usr/bin/env elixir

defmodule PWC do
  def sum_frequencies(str) do
    max_vowels = String.graphemes(str)
    |> Enum.filter(fn c -> String.contains?("aeiou", c) end)
    |> Enum.frequencies
    |> Map.values
    |> Enum.max(&>=/2, fn -> 0 end)
    max_consonants = String.graphemes(str)
    |> Enum.filter(fn c -> not String.contains?("aeiou", c) end)
    |> Enum.frequencies
    |> Map.values
    |> Enum.max(&>=/2, fn -> 0 end)
    max_vowels + max_consonants
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{sum_frequencies(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("banana")

IO.puts("\nExample 2:")
PWC.solution("teestett")

IO.puts("\nExample 3:")
PWC.solution("aeiouuaa")

IO.puts("\nExample 4:")
PWC.solution("rhythm")

IO.puts("\nExample 5:")
PWC.solution("x")
