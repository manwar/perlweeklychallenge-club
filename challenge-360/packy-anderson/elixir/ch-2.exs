#!/usr/bin/env elixir

defmodule PWC do
  def word_sorter(str) do
    str
    |> String.split
    |> Enum.sort_by(&String.downcase/1)
    |> Enum.join(" ")
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{word_sorter(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("The quick brown fox")

IO.puts("\nExample 2:")
PWC.solution("Hello    World!   How   are you?")

IO.puts("\nExample 3:")
PWC.solution("Hello")

IO.puts("\nExample 4:")
PWC.solution("Hello, World! How are you?")

IO.puts("\nExample 5:")
PWC.solution("I have 2 apples and 3 bananas!")
