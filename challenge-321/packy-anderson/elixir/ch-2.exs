#!/usr/bin/env elixir

defmodule PWC do
  defp repeatReplace(str) do
    s = Regex.replace(~r/.\#/, str, "")
    cond do
      s != str -> repeatReplace(s)
      true     -> s
    end
  end

  def backspaceCompare(str1, str2) do
    repeatReplace(str1) == repeatReplace(str2)
  end

  def solution(str1, str2) do
    IO.puts("Input: $str1 = \"#{str1}\"")
    IO.puts("       $str2 = \"#{str2}\"")
    IO.puts("Output: #{ backspaceCompare(str1, str2) }" )
  end
end

IO.puts("Example 1:")
PWC.solution("ab#c", "ad#c")

IO.puts("\nExample 2:")
PWC.solution("ab##", "a#b#")

IO.puts("\nExample 3:")
PWC.solution("a#b", "c")
