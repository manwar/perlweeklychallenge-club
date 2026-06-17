#!/usr/bin/env elixir

defmodule PWC do
  def second_largest_digit(str) do
    {_, two} = str
    |> String.codepoints
    |> Enum.reduce([], fn c, list ->
      list ++ if Regex.match?(~r/\d/, c) do
        [ String.to_integer(c)]
      else [] end
    end)
    |> Enum.reduce({-1, -1}, fn digit, {one, two} ->
      cond do
        digit > one                 -> {digit, one}
        digit < one and digit > two -> {one, digit}
        true                        -> {one, two}
      end
    end)
    two
  end

  def solution(str) do
    IO.puts("Input: $str = \"" <> str <> "\"")
    IO.puts("Output: #{second_largest_digit(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("aaaaa77777")

IO.puts("\nExample 2:")
PWC.solution("abcde")

IO.puts("\nExample 3:")
PWC.solution("9zero8eight7seven9")

IO.puts("\nExample 4:")
PWC.solution("xyz9876543210")

IO.puts("\nExample 5:")
PWC.solution("4abc4def2ghi8jkl2")
