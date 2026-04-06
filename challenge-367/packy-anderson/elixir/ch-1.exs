#!/usr/bin/env elixir

defmodule PWC do
  def max_odd_binary(str) do
    bits = str |> String.graphemes |> Enum.sort |> Enum.reverse
    {head, bits} = {hd(bits), tl(bits)}
    bits ++ [head] |> Enum.join
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{max_odd_binary(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("1011")

IO.puts("\nExample 2:")
PWC.solution("100")

IO.puts("\nExample 3:")
PWC.solution("111000")

IO.puts("\nExample 4:")
PWC.solution("0101")

IO.puts("\nExample 5:")
PWC.solution("1111")
