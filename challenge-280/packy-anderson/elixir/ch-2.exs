#!/usr/bin/env elixir

defmodule PWC do
  def countAsterisks(str) do
    str
    |> String.replace(~r/\|[^|]+\|/, "")
    |> String.replace(~r/[^*]+/, "")
    |> String.length
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: " <> to_string(countAsterisks(str)) )
  end
end

IO.puts("Example 1:")
PWC.solution("p|*e*rl|w**e|*ekly|")

IO.puts("\nExample 2:")
PWC.solution("perl")

IO.puts("\nExample 3:")
PWC.solution("th|ewe|e**|k|l***ych|alleng|e")
