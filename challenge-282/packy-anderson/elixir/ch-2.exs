#!/usr/bin/env elixir

defmodule PWC do
  def keyChanges([], _, count), do: count

  def keyChanges([char | rest], last, count) do
    char = String.downcase(char)
    last = String.downcase(last)
    cond do
      char == last -> keyChanges(rest, char, count)
      true         -> keyChanges(rest, char, count + 1)
    end
  end

  def keyChanges(str) do
    [first | rest] = String.graphemes(str)
    keyChanges(rest, first, 0)
  end

  def solution(str) do
    IO.puts("Input: $str = '#{str}'")
    IO.puts("Output: " <> to_string(keyChanges(str)) )
  end
end

IO.puts("Example 1:")
PWC.solution("pPeERrLl")

IO.puts("\nExample 2:")
PWC.solution("rRr")

IO.puts("\nExample 3:")
PWC.solution("GoO")
