#!/usr/bin/env elixir

defmodule PWC do
  # we've looped over all the words using j
  def match_substring(_, _, j, len, matches, seen)
  when j == len, do: {matches, seen}

  # we're not matching substrings against themselves
  def match_substring(words, i, j, len, matches, seen)
  when i==j do
    match_substring(words, i, j+1, len, matches, seen)
  end

  def match_substring(words, i, j, len, matches, seen) do
    substring = Enum.at(words, i)
    string    = Enum.at(words, j)
    if String.contains?(string, substring) do
      matches = matches ++ [substring]
      # it matches at least one, we don't have to check the rest
      {matches, seen}
    else
      match_substring(words, i, j+1, len, matches, seen)
    end
  end

  # we've looped over all the words using i
  def match_string(_, i, len, matches, _)
  when i == len, do: matches

  def match_string(words, i, len, matches, seen) do
    substring = Enum.at(words, i)
    {matches, seen} = if Map.get(seen, substring) do
      # skip if we've already considered this substring
      match_substring(
        words, i+1, 0, len, matches, seen
      )
    else
      # add substring to seen for future iterations
      match_substring(
        words, i, 0, len, matches, Map.put(seen, substring, 1)
      )
    end
    match_string(words, i+1, len, matches, seen)
  end

  def match_string(words) do
    match_string(words, 0, length(words), [], %{})
  end

  def solution(words) do
    quoted = words
    |> Enum.map(fn w -> "\"#{w}\"" end)
    |> Enum.join(", ")
    IO.puts("Input: @ints = (#{quoted})")
    quoted = match_string(words)
    |> Enum.map(fn w -> "\"#{w}\"" end)
    |> Enum.join(", ")
    IO.puts("Output: (#{quoted})")
  end
end

IO.puts("Example 1:")
PWC.solution(["cat", "cats", "dog", "dogcat", "dogcat", "rat",
              "ratcatdogcat"])

IO.puts("\nExample 2:")
PWC.solution(["hello", "hell", "world", "wor", "ellow",
              "elloworld"])

IO.puts("\nExample 3:")
PWC.solution(["a", "aa", "aaa", "aaaa"])

IO.puts("\nExample 4:")
PWC.solution(["flower", "flow", "flight", "fl", "fli", "ig",
              "ght"])

IO.puts("\nExample 5:")
PWC.solution(["car", "carpet", "carpenter", "pet", "enter",
              "pen", "pent"])
