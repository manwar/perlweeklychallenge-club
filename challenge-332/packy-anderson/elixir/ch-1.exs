#!/usr/bin/env elixir

defmodule PWC do

  def binary_date(date) do
    date
    |> String.split("-")
    |> Enum.map(fn s -> String.to_integer(s) end)
    |> Enum.map(fn i -> Integer.digits(i, 2) |> Enum.join end)
    |> Enum.join("-")
  end

  def solution(date) do
    IO.puts("Input: $date = \"#{date}\"")
    IO.puts("Output: \"#{binary_date(date)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("2025-07-26")

IO.puts("\nExample 2:")
PWC.solution("2000-02-02")

IO.puts("\nExample 3:")
PWC.solution("2024-12-31")
