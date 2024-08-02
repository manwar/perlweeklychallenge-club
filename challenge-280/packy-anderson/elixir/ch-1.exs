#!/usr/bin/env elixir

defmodule PWC do
  def twiceAppearance([], _), do: "␀" # fallback

  def twiceAppearance([next | rest], count) do
    if Map.has_key?(count, next) do
      next
    else
      twiceAppearance(rest, Map.put(count, next, 1))
    end
  end

  def twiceAppearance(str) do
    # split the string into characters and
    # reprocess with an empty Map
    twiceAppearance(String.graphemes(str), %{})
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{twiceAppearance(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("acbddbca")

IO.puts("\nExample 2:")
PWC.solution("abccd")

IO.puts("\nExample 3:")
PWC.solution("abcdabbb")

IO.puts("\nExample 4:")
PWC.solution("abcdefg")
