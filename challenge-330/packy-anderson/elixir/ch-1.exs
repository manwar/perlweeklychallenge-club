#!/usr/bin/env elixir

defmodule PWC do
  def clear_digits(str) do
    if Regex.match?(~r/\D\d/, str),
      do: clear_digits(Regex.replace(~r/\D\d/,str,"")),
      else: str
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{clear_digits(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("cab12")

IO.puts("\nExample 2:")
PWC.solution("xy99")

IO.puts("\nExample 3:")
PWC.solution("pa1erl")
