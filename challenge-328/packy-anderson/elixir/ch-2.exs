#!/usr/bin/env elixir

defmodule PWC do
  # sanity check: only check if it's long enough
  def has_bad_match(str) when length(str) < 2, do: str

  def has_bad_match(str) do
    # match a sequence of two of the same character,
    # but be case-insensitive
    match = Regex.run(~r/(\p{L})\1/i, str, capture: :first)
    if match do
      # pull the match out of the list returned by Regex.run/3
      match = match |> List.first
      # in case we need to search later in the string, get
      # the portion of the string AFTER the match
      after_match = String.split(str, match, parts: 2)
                  |> List.last
      # get the characters matched
      char1 = match |> String.first
      char2 = match |> String.last
      if char1 != char2 do
        # it's not the same character, same case
        if char1 == String.downcase(char2) or
           char1 == String.upcase(char2) do
          # they're the same character with different case!
          match
        else
          # they're different characters
          has_bad_match(after_match)
        end
      else
        # it IS the same character, same case
        has_bad_match(after_match)
      end
    else
      # we didn't match, so return false
      nil
    end
  end

  def good_string(str) do
    # see if the string has a sequence of the same character twice,
    # once upper case and once lower case, in any order
    match = has_bad_match(str)

    if match do
      # we don't need a regular expression, since we have the
      # character pair in match, we can use String.replace/4
      #
      # recursively call the function with the new string
      good_string(String.replace(str, match, "", global: false))
    else
      # return the unmodified string if there are no matches
      str
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{good_string(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("WeEeekly")

IO.puts("\nExample 2:")
PWC.solution("abBAdD")

IO.puts("\nExample 3:")
PWC.solution("abc")
