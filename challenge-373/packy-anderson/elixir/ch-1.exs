#!/usr/bin/env elixir

defmodule PWC do
  def equal_list(arr1, arr2) do
    Enum.join(arr1) == Enum.join(arr2)
  end

  def quote_list(arr), do:
    arr |> Enum.map(fn e -> "\"#{e}\"" end) |> Enum.join(", ")

  def solution(arr1, arr2) do
    IO.puts("Input: @arr1 = (" <> quote_list(arr1) <> ")")
    IO.puts("       @arr2 = (" <> quote_list(arr2) <> ")")
    IO.puts("Output: #{equal_list(arr1, arr2)}")
  end
end

IO.puts("Example 1:")
PWC.solution(["a", "bc"], ["ab", "c"])

IO.puts("\nExample 2:")
PWC.solution(["a", "b", "c"], ["a", "bc"])

IO.puts("\nExample 3:")
PWC.solution(["a", "bc"], ["a", "c", "b"])

IO.puts("\nExample 4:")
PWC.solution(["ab", "c", ""], ["", "a", "bc"])

IO.puts("\nExample 5:")
PWC.solution(["p", "e", "r", "l"], ["perl"])
