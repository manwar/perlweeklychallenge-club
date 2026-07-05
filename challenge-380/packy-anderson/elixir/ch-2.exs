#!/usr/bin/env elixir

defmodule PWC do
  def reversed_pos(char), do:
    String.graphemes("zyxwvutsrqponmlkjihgfedcba")
    |> Enum.find_index(fn c -> c == char end)
    |> then( &( &1+1 ) )

  def reverse_degree(str) do
    String.graphemes(str)
    |> Enum.reduce({0, 1}, fn c, {sum, pos} ->
      { sum + (reversed_pos(c) * pos), pos+1 }
    end)
    |> elem(0)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{reverse_degree(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("z")

IO.puts("\nExample 2:")
PWC.solution("a")

IO.puts("\nExample 3:")
PWC.solution("bbc")

IO.puts("\nExample 4:")
PWC.solution("racecar")

IO.puts("\nExample 5:")
PWC.solution("zyx")
