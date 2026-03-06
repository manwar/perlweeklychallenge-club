#!/usr/bin/env elixir

defmodule PWC do
  defp word_map(), do: %{
    "naught"    => 0,
    "nought"    => 0,
    "zero"      => 0,
    "one"       => 1,
    "two"       => 2,
    "three"     => 3,
    "four"      => 4,
    "five"      => 5,
    "six"       => 6,
    "seven"     => 7,
    "eight"     => 8,
    "nine"      => 9,
    "ten"       => 10,
    "eleven"    => 11,
    "twelve"    => 12,
    "thirteen"  => 13,
    "fourteen"  => 14,
    "fifteen"   => 15,
    "sixteen"   => 16,
    "seventeen" => 17,
    "eighteen"  => 18,
    "nineteen"  => 19,
    "ninteen"   => 19, # common(?) mispelling
    "twenty"    => 20,
    "thirty"    => 30,
    "forty"     => 40,
    "fourty"    => 40,
    "fifty"     => 50,
    "sixty"     => 60,
    "seventy"   => 70,
    "eighty"    => 80,
    "ninety"    => 90,
    "ninty"     => 90, # common mispelling
  }

  defp words2num([], num), do: num
  defp words2num([word | words], num), do:
    words2num(words, num + Map.get(word_map(), word, 0))
  defp words2num(words), do:
    words2num(
      words |> String.replace("-", " ") |> String.split, 0
    )

  defp extract_regex() do
    "(?<string>\\w+)\\s+\\S+\\s+" <>
    "(?<vowels>.+)\\s+vowels?" <>
    "\\s+and\\s+" <>
    "(?<consonants>.+)\\s+consonants?" |> Regex.compile!("x")
  end

  defp vowels(str),     do: Regex.replace(~r/[^aeiou]/, str, "")
  defp consonants(str), do: Regex.replace(~r/[aeiou]/, str, "")

  def lie_detector(str) do
    parsed = Regex.named_captures(extract_regex(), str)
    string = Map.get(parsed, "string")
    vowel_count     = vowels(string)     |> String.length
    consonant_count = consonants(string) |> String.length
    vowel_claim     = words2num(Map.get(parsed, "vowels"))
    consonant_claim = words2num(Map.get(parsed, "consonants"))

    vowel_count == vowel_claim and
    consonant_count == consonant_claim
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{lie_detector(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("aa — two vowels and zero consonants")

IO.puts("\nExample 2:")
PWC.solution("iv — one vowel and one consonant")

IO.puts("\nExample 3:")
PWC.solution("hello - three vowels and two consonants")

IO.puts("\nExample 4:")
PWC.solution("aeiou — five vowels and zero consonants")

IO.puts("\nExample 5:")
PWC.solution("aei — three vowels and zero consonants")
