#!/usr/bin/env elixir

defmodule PWC do
  def my_reverse(str) do
    String.codepoints(str)
    |> Enum.reduce("", fn char, rts -> char <> rts end)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{my_reverse(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("")

IO.puts("\nExample 2:")
PWC.solution("reverse the given string")

IO.puts("\nExample 3:")
PWC.solution("Perl is Awesome")

IO.puts("\nExample 4:")
PWC.solution("v1.0.0-Beta!")

IO.puts("\nExample 5:")
PWC.solution("racecar")
