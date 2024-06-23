#!/usr/bin/env elixir

defmodule PWC do
  @startsWithVowel Regex.compile!("^[aeiou]", "i")

  def addAs([], list, _), do: list

  def addAs([first | rest], list, a_count) do
    list = list ++ [ first <> String.duplicate("a", a_count) ]
    addAs(rest, list, a_count + 1)
  end

  def goatWord(word) do
    if Regex.run(@startsWithVowel, word) do
      word <> "ma"
    else
      first = String.first(word)
      rest  = String.slice(word, 1 .. -1//1)
      rest <> first <> "ma"
    end
  end

  def goatLatin(sentence) do
    String.split(sentence)
    |> Enum.map(&goatWord/1)
    |> addAs([], 1)
    |> Enum.join(" ")
  end

  def solution(sentence) do
    IO.puts("Input: $sentence = \"#{ sentence }\"")
    IO.puts("Output: \"#{ goatLatin(sentence) }\"")
  end
end

IO.puts("Example 1:")
PWC.solution("I love Perl")

IO.puts("\nExample 2:")
PWC.solution("Perl and Raku are friends")

IO.puts("\nExample 3:")
PWC.solution("The Weekly Challenge")

IO.puts("\nExample 4:")
PWC.solution("Bus stop Bus goes She stays Love grows Under my umbrella")
