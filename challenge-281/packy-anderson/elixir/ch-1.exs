#!/usr/bin/env elixir

defmodule PWC do
  require Integer

  def isLight(coordinates) do
    letter = String.first(coordinates)
    {num, _} = Integer.parse(String.last(coordinates))
    cond do
      String.contains?("aceg", letter)
        and Integer.is_even(num) -> "true"
      String.contains?("bdfh", letter)
        and Integer.is_odd(num)  -> "true"
      true -> "false"
    end
  end

  def solution(coordinates) do
    IO.puts("Input: $coordinates = \"#{coordinates}\"")
    IO.puts("Output: " <> isLight(coordinates) )
  end
end

IO.puts("Example 1:")
PWC.solution("d3")

IO.puts("\nExample 2:")
PWC.solution("g5")

IO.puts("\nExample 3:")
PWC.solution("e6")
