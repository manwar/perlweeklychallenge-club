#!/usr/bin/env elixir

defmodule PWC do
  def str_val(s) do
    case Integer.parse(s) do
      {int, _} -> int
      :error   -> String.length(s)
    end
  end

  def max_str_val(strings) do
    strings
    |> Enum.map(fn s -> str_val(s) end)
    |> Enum.max
  end

  def solution(strings) do
    strlist = strings
    |> Enum.map(fn s -> "\"#{s}\"" end)
    |> Enum.join(", ")
    IO.puts("Input: @strings = (#{strlist})")
    IO.puts("Output: #{max_str_val(strings)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["123", "45", "6"])

IO.puts("\nExample 2:")
PWC.solution(["abc", "de", "fghi"])

IO.puts("\nExample 3:")
PWC.solution(["0012", "99", "a1b2c"])

IO.puts("\nExample 4:")
PWC.solution(["x", "10", "xyz", "007"])

IO.puts("\nExample 5:")
PWC.solution(["hello123", "2026", "perl"])
