#!/usr/bin/env elixir

defmodule PWC do
  import Enum

  def diff_array_as_string(word) do
    arr = word
    |> String.to_charlist
    |> map(& &1 - 97)

    map(0..length(arr)-2, & at(arr, &1+1) - at(arr, &1) )
    |> join(" ")
  end

  def string_difference(words) do
    reduce(words, %{}, fn word, diffs ->
      diff = diff_array_as_string(word)
      Map.put(diffs, diff, Map.get(diffs, diff, []) ++ [word])
    end)
    |> Map.values
    |> filter(& length(&1) == 1)
    |> List.first! # first element from list of lists of length 1
    |> List.first!
  end

  def quote_join(array) do
    Enum.map(array, &("\"#{&1}\"")) |> Enum.join(", ")
  end

  def solution(words) do
    IO.puts("Input: @words = (" <> quote_join(words) <> ")")
    IO.puts("Output: \"#{string_difference(words)}\"")
  end
end

IO.puts("Example 1")
PWC.solution(["ab", "bc", "cd", "zy"])

IO.puts("\nExample 2")
PWC.solution(["cba", "fed", "azy"])

IO.puts("\nExample 3")
PWC.solution(["pop", "ada", "beb", "cfc"])

IO.puts("\nExample 4")
PWC.solution(["aaaa", "zzzz", "mmmm", "aaba"])

IO.puts("\nExample 5")
PWC.solution(["aceg", "bdfh", "cegi", "azbz"])
