#!/usr/bin/env elixir

defmodule PWC do
  @vowels "[aeiou]"

  @starts_or_ends_with_vowel Regex.compile!(
    "\\b#{@vowels}|#{@vowels}\\b"
  )

  def wordCount(words) do
    {_, matched} = Enum.map_reduce(words, [], fn word, list ->
      list = if Regex.match?(@starts_or_ends_with_vowel, word) do
        [ word | list ]
      else
        list
      end
      # always have to return the both
      # the value and the accumulator
      {word, list}
    end)
    length(matched)
  end

  def solution(words) do
    IO.puts("Input: @ints = (" <> Enum.join(words, ", ") <> ")")
    IO.puts("Output: " <> to_string(wordCount(words)) )
  end
end

IO.puts("Example 1:")
PWC.solution(["unicode", "xml", "raku", "perl"])

IO.puts("\nExample 2:")
PWC.solution(["the", "weekly", "challenge"])

IO.puts("\nExample 3:")
PWC.solution(["perl", "python", "postgres"])
