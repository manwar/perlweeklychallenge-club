#!/usr/bin/env elixir

defmodule PWC do
  def parser(str) do
    str
    |> String.replace(~r/\(al\)/, "al")
    |> String.replace(~r/\(\)/,   "o")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{parser(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("G()(al)")

IO.puts("\nExample 2:")
PWC.solution("G()()()()(al)")

IO.puts("\nExample 3:")
PWC.solution("(al)G(al)()()")

IO.puts("\nExample 4:")
PWC.solution("()G()G")

IO.puts("\nExample 5:")
PWC.solution("(al)(al)G()()")
