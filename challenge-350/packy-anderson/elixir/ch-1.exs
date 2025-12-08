#!/usr/bin/env elixir

defmodule PWC do
  def good_string(_, good, i, m) when i >= m, do: good

  def good_string(str, good, i, m) do
    bag = str
    |> String.slice(i..i+2) # get the substring
    |> String.graphemes     # split into characters
    |> Enum.frequencies     # make the map
    good = if Enum.any?(Map.values(bag), fn x -> x > 1 end) do
      good
    else
      good+1
    end
    good_string(str, good, i+1, m)
  end

  def good_string(str) do
    good_string(str, 0, 0, String.length(str) - 2)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{good_string(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("abcaefg")

IO.puts("\nExample 2:")
PWC.solution("xyzzabc")

IO.puts("\nExample 3:")
PWC.solution("aababc")

IO.puts("\nExample 4:")
PWC.solution("qwerty")

IO.puts("\nExample 5:")
PWC.solution("zzzaaa")
