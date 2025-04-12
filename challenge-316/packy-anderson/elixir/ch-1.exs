#!/usr/bin/env elixir

defmodule PWC do
  def circular(list) when length(list) <= 1, do: true
  def circular([one | list]) do
    # get the last letter of the first element
    last  = one              |> String.last
    # and the first letter of the second element
    first = Enum.at(list, 0) |> String.first
    # if they don't match case-insensitively, return false
    if (String.downcase(last) != String.downcase(first)) do
      false
    else
      # process the list without the first element
      circular(list)
    end
  end

  def solution(list) do
    IO.puts("Input: @ints = (\"" <> Enum.join(list, "\", \"") <> "\")")
    IO.puts("Output: " <> to_string(circular(list)) )
  end
end

IO.puts("Example 1:")
PWC.solution(["perl", "loves", "scala"])

IO.puts("\nExample 2:")
PWC.solution(["love", "the", "programming"])

IO.puts("\nExample 3:")
PWC.solution(["java", "awk", "kotlin", "node.js"])
