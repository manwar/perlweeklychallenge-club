#!/usr/bin/env elixir

defmodule PWC do
  def echo([], _), do: ""

  def echo([c | rest], i) do
    String.duplicate(c, i) <> echo(rest, i+1)
  end

  def echo(string), do:
    echo(String.graphemes(string), 1)

  def solution(string) do
    IO.puts("Input: \"#{string}\"")
    IO.puts("Output: \"#{echo(string)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("abca")

IO.puts("\nExample 2:")
PWC.solution("xyz")

IO.puts("\nExample 3:")
PWC.solution("code")

IO.puts("\nExample 4:")
PWC.solution("hello")

IO.puts("\nExample 5:")
PWC.solution("a")
