#!/usr/bin/env elixir

defmodule PWC do
  # if we've run off the end of the second string,
  # this character isn't in the second string
  def subsequence(_str1, str2, _p1, p2) when p2 >= byte_size(str2),
    do: false

  # if we've run off the end of the first string,
  # we wound up finding all the characters!
  def subsequence(str1, _str2, p1, _p2) when p1 >= byte_size(str1),
    do: true

  def subsequence(str1, str2, p1, p2) do
    # if the current character of the first string matches
    # the current character of the second string...
    if String.at(str1, p1) == String.at(str2, p2) do
      # move to the next character in the first string
      subsequence(str1, str2, p1+1, p2)
    else
      # move to the next character of the second string
      subsequence(str1, str2, p1, p2+1)
    end
  end

  def subsequence(str1, str2) do
    # start at the beginning of both strings
    subsequence(str1, str2, 0, 0)
  end

  def solution(str1, str2) do
    IO.puts("Input: $str1 = \"#{str1}\", $str2 = \"#{str2}\"")
    IO.puts("Output: " <> to_string(subsequence(str1, str2)) )
  end
end

IO.puts("Example 1:")
PWC.solution("uvw", "bcudvew")

IO.puts("\nExample 2:")
PWC.solution("aec", "abcde")

IO.puts("\nExample 3:")
PWC.solution("sip", "javascript")
