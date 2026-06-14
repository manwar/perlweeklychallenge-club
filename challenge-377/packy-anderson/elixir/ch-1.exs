#!/usr/bin/env elixir

defmodule PWC do
  def reverse_existence([], _), do: "false"
  def reverse_existence([substr | tail], rts) do
    if String.contains?(rts, substr), do: "true",
    else: reverse_existence(tail, rts)
  end

  def reverse_existence(str) do
    0..String.length(str)-2
    |> Enum.reduce([],
         fn i, list -> list ++ [String.slice(str, i, 2)] end)
    |> reverse_existence(String.reverse(str))
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{reverse_existence(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("abcba")

IO.puts("\nExample 2:")
PWC.solution("racecar")

IO.puts("\nExample 3:")
PWC.solution("abcd")

IO.puts("\nExample 4:")
PWC.solution("banana")

IO.puts("\nExample 5:")
PWC.solution("hello")
