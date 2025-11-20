#!/usr/bin/env elixir

defmodule PWC do
  def count_vowels(str) do
    str = str |> String.replace(~r/[^aeiou]/i, "")
    count = String.length(str)
    vowels = if count == 1, do: "vowel", else: "vowels"
    { count, vowels }
  end

  def string_alike(str) do
    # split the string
    half_len = Integer.floor_div(String.length(str), 2)
    first    = String.slice(str, 0, half_len)
    second   = String.slice(str, half_len, half_len)
    # count the vowels
    {count1, vowel1} = count_vowels(first)
    explain = "1st half: \"#{first}\" (#{count1} #{vowel1})\n"
    {count2, vowel2} = count_vowels(second)
    explain = explain
           <> "2nd half: \"#{second}\" (#{count2} #{vowel2})"
    # return the result
    bool = if count1 == count2 and count1 > 0, do: "True",
                                             else: "False"
    "#{bool}\n\n#{explain}"
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> string_alike(str))
  end
end

IO.puts("Example 1:")
PWC.solution("textbook")

IO.puts("\nExample 2:")
PWC.solution("book")

IO.puts("\nExample 3:")
PWC.solution("AbCdEfGh")

IO.puts("\nExample 4:")
PWC.solution("rhythmmyth")

IO.puts("\nExample 5:")
PWC.solution("UmpireeAudio")
