#!/usr/bin/env elixir

defmodule PWC do
  def group_division(str, size, filler) do
    chunks = ceil(String.length(str) / size)
    str = String.pad_trailing(str, chunks * size, filler)
    Range.to_list(0..String.length(str)-1//size)
    |> Enum.map(fn i -> String.slice(str, i, size) end)
  end

  def solution(str, size, filler) do
    IO.puts("Input: $str = \"#{str}\", $size = #{size}, $filler = \"#{filler}\"")
    results = group_division(str, size, filler)
    |> Enum.map(fn s -> "\"#{s}\"" end) |> Enum.join(", ")
    IO.puts("Output: (#{results})")
  end
end

IO.puts("Example 1:")
PWC.solution("RakuPerl", 4, "*")

IO.puts("\nExample 2:")
PWC.solution("Python", 5, "0")

IO.puts("\nExample 3:")
PWC.solution("12345", 3, "x")

IO.puts("\nExample 4:")
PWC.solution("HelloWorld", 3, "_")

IO.puts("\nExample 5:")
PWC.solution("AI", 5, "!")
