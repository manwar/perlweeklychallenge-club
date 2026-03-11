#!/usr/bin/env elixir

defmodule PWC do
  def to_char(match), do:
    match
    |> String.replace("#", "")
    |> String.to_integer
    |> Kernel.+(96)
    |> then(fn x -> [x] end)

  def decrypt(str) do
    str
    |> String.replace(~r/\d\d\#/, fn x -> to_char(x) end)
    |> String.replace(~r/\d/,     fn x -> to_char(x) end)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{decrypt(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("10#11#12")

IO.puts("\nExample 2:")
PWC.solution("1326#")

IO.puts("\nExample 3:")
PWC.solution("25#24#123")

IO.puts("\nExample 4:")
PWC.solution("20#5")

IO.puts("\nExample 5:")
PWC.solution("1910#26#")
