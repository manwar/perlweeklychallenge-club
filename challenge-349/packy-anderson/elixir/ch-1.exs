#!/usr/bin/env elixir

defmodule PWC do
  def power_string([], _, count, longest) when count > longest,
    do: count # last sequence is longest
  def power_string([], _, _, longest),
    do: longest

  def power_string([current | chars], last, count, longest) do
    cond do
      current == last -> # same as last char
        power_string(chars, last, count+1, longest)
      true -> # character has changed
        longest = if count > longest, do: count, else: longest
        power_string(chars, current, 1, longest)
    end
  end

  def power_string(str) do
    chars = String.graphemes(str)
    power_string(tl(chars), hd(chars), 1, 0)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> to_string(power_string(str)))
  end
end

IO.puts("Example 1:")
PWC.solution("textbook")

IO.puts("\nExample 2:")
PWC.solution("aaaaa")

IO.puts("\nExample 3:")
PWC.solution("hoorayyy")

IO.puts("\nExample 4:")
PWC.solution("x")

IO.puts("\nExample 5:")
PWC.solution("aabcccddeeffffghijjk")
