#!/usr/bin/env elixir

defmodule PWC do
  def check_substrings(str) do
    if Regex.match?(~r/(?=.*a)(?=.*e)(?=.*i)(?=.*o).*u.*/, str) do
      [ str ]
      ++ check_substrings(String.slice(str, 1..-1//1))
      ++ check_substrings(String.slice(str, 0..-2//1))
    else
      []
    end
    |> Enum.uniq
  end

  def count_vowel(str) do
    Regex.split(~r/[^aeiou]+/, str)
    |> Enum.reduce([], &(&2 ++ check_substrings(&1)))
    |> Enum.sort
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    output = count_vowel(str)
    |> Enum.map(&("\"#{&1}\""))
    |> Enum.join(", ")
    IO.puts("Output: (#{output})")
  end
end

IO.puts("Example 1:")
PWC.solution("aeiou")

IO.puts("\nExample 2:")
PWC.solution("aaeeeiioouu")

IO.puts("\nExample 3:")
PWC.solution("aeiouuaxaeiou")

IO.puts("\nExample 4:")
PWC.solution("uaeiou")

IO.puts("\nExample 5:")
PWC.solution("aeioaeioa")
