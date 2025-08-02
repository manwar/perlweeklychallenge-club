#!/usr/bin/env elixir

defmodule PWC do

  def charPercent(strVal, charVal) do
    char_cnt = strVal
    |> String.graphemes
    |> Enum.filter(fn c -> c == charVal end)
    |> length
    trunc(round( ( char_cnt / String.length(strVal) ) * 100 ))
  end

  def solution(strVal, charVal) do
    IO.puts("Input: $str = \"#{strVal}\", $char = \"#{charVal}\"")
    IO.puts("Output: " <> to_string(charPercent(strVal, charVal) ))
  end
end

IO.puts("Example 1:")
PWC.solution("perl", "e")

IO.puts("\nExample 2:")
PWC.solution("java", "a")

IO.puts("\nExample 3:")
PWC.solution("python", "m")

IO.puts("\nExample 4:")
PWC.solution("ada", "a")

IO.puts("\nExample 5:")
PWC.solution("ballerina", "l")

IO.puts("\nExample 6:")
PWC.solution("analitik", "k")
