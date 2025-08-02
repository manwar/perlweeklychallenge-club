#!/usr/bin/env elixir

defmodule PWC do
  def groupPosition(str) do
    # will return a list of [entire_match, matching_char]
    # tuples for each group matched
    groups = Regex.scan(~r/([a-z])\1\1+/i, str)
    if Enum.empty?(groups) do
      "\"\""
    else
      groups
        # grab the entire match from each group tuple
        # and wrap it in quotes
        |> Enum.map(&( "\"#{ List.first(&1) }\"" ))
        |> Enum.join(", ")
    end
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> groupPosition(str) )
  end
end

IO.puts("Example 1:")
PWC.solution("abccccd")

IO.puts("\nExample 2:")
PWC.solution("aaabcddddeefff")

IO.puts("\nExample 3:")
PWC.solution("abcdd")
