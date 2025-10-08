#!/usr/bin/env elixir

defmodule PWC do
  def max_score(_, len, split, _, max, explain)
    when split >= len, do: {max, explain}

  def max_score(str, len, split, count, max, explain) do
    left  = String.slice(str, 0, split)
    right = String.slice(str, split, len)
    zeros = left |> String.graphemes
      |> Enum.filter(fn c -> c == "0" end) |> length
    ones  = right|> String.graphemes
      |> Enum.filter(fn c -> c == "1" end) |> length
    sum   = zeros + ones
    explain = explain
      <> "\n#{count}: left = \"#{left}\", right = \"#{right}\""
      <> " => #{zeros} + #{ones} => #{sum}"
    max = max(max, sum)
    max_score(str, len, split+1, count+1, max, explain)
  end

  def max_score(str) do
    max_score(str, String.length(str), 1, 1, 0, "")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    {max, explain} = max_score(str)
    IO.puts("Output: #{max}\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution("0011")

IO.puts("\nExample 2:")
PWC.solution("0000")

IO.puts("\nExample 3:")
PWC.solution("1111")

IO.puts("\nExample 4:")
PWC.solution("0101")

IO.puts("\nExample 5:")
PWC.solution("011101")
