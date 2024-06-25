#!/usr/bin/env elixir

defmodule PWC do
  def replaceDigits([], _, out), do: out

  def replaceDigits([c | rest], last, out) do
    if Regex.match?(~r/[0-9]/, c) do
      <<chrval::utf8>> = last
      c = List.to_string([ chrval + String.to_integer(c) ])
      replaceDigits(rest, last, out <> c)
    else
      replaceDigits(rest, c, out <> c)
    end
  end

  def replaceDigits(str) do
    replaceDigits(String.graphemes(str), nil, "")
  end

  def solution(str) do
    IO.puts("Input: $str = '#{str}'")
    IO.puts("Output: '#{replaceDigits(str)}'")
  end
end

IO.puts("Example 1:")
PWC.solution("a1c1e1")

IO.puts("\nExample 2:")
PWC.solution("a1b2c3d4")

IO.puts("\nExample 3:")
PWC.solution("b2b")

IO.puts("\nExample 4:")
PWC.solution("a16z")
