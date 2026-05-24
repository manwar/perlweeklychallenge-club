#!/usr/bin/env elixir

defmodule PWC do
  def word_break(str, words) do
    str = Enum.map(words, &( Regex.compile!(&1)))
    |> Enum.reduce(str, fn pattern, str ->
      Regex.replace(pattern, str, " ")
    end)
    if Regex.match?(~r/\A\s*\z/, str), do: "true", else: "false"
  end

  def solution(str, words) do
    wordlist = Enum.map(words, &("\"#{&1}\"")) |> Enum.join(", ")
    IO.puts("Input: $str = '#{str}', @words = (#{wordlist})")
    IO.puts("Output: #{word_break(str, words)}")
  end
end

IO.puts("Example 1:")
PWC.solution("weeklychallenge", ["challenge", "weekly"])

IO.puts("\nExample 2:")
PWC.solution("perlrakuperl", ["raku", "perl"])

IO.puts("\nExample 3:")
PWC.solution("sonsanddaughters", ["sons", "sand", "daughters"])

IO.puts("\nExample 4:")
PWC.solution("raperlrakuperlku", ["raku", "perl"])

IO.puts("\nExample 5:")
PWC.solution("thequickbrownfoxx", ["the", "quick", "brown", "fox"])
