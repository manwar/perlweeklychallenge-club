#!/usr/bin/env elixir

defmodule PWC do
  def duplicate_removal(str) do
    match = Regex.run(~r/(\p{L})\1/, str, capture: :first)
    if match do
      String.replace(str, match, "", global: false)
      |> duplicate_removal
    else
      str
    end
  end

  def solution(str) do
    IO.puts("Input: $str = '#{str}'")
    IO.puts("Output: '#{duplicate_removal(str)}'")
  end
end

IO.puts("Example 1:")
PWC.solution("abbaca")

IO.puts("\nExample 2:")
PWC.solution("azxxzy")

IO.puts("\nExample 3:")
PWC.solution("aaaaaaaa")

IO.puts("\nExample 4:")
PWC.solution("aabccba")

IO.puts("\nExample 5:")
PWC.solution("abcddcba")
