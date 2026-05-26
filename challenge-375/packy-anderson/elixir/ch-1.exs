#!/usr/bin/env elixir

defmodule PWC do
  def single_set(array) do
    Enum.frequencies(array)
    |> Enum.filter(fn {_, v} -> v == 1 end)
    |> Map.new
  end

  def single_common_count(array1, array2) do
    Map.intersect(single_set(array1), single_set(array2))
    |> Map.keys |> length
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(array1, array2) do
    IO.puts("Input: @array1 = (" <> quote_join(array1) <> ")")
    IO.puts("       @array2 = (" <> quote_join(array2) <> ")")
    IO.puts("Output: #{single_common_count(array1, array2)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["apple", "banana", "cherry"],
             ["banana", "cherry", "date"])

IO.puts("\nExample 2:")
PWC.solution(["a", "ab", "abc"],
             ["a", "a", "ab", "abc"])

IO.puts("\nExample 3:")
PWC.solution(["orange", "lemon"],
             ["grape", "melon"])

IO.puts("\nExample 4:")
PWC.solution(["test", "test", "demo"],
             ["test", "demo", "demo"])

IO.puts("\nExample 5:")
PWC.solution(["Hello", "world"],
             ["hello", "world"])
