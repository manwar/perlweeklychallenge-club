#!/usr/bin/env elixir

defmodule PWC do
  def last_word(str) do
    str |> String.split |> List.last |> String.length
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{last_word(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("The Weekly Challenge")

IO.puts("\nExample 2:")
PWC.solution("   Hello   World    ")

IO.puts("\nExample 3:")
PWC.solution("Let's begin the fun")
