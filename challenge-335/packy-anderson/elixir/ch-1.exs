#!/usr/bin/env elixir

defmodule PWC do
  def bag(word) do
    {_, bag} = word
    |> String.graphemes
    |> Enum.map_reduce(%{}, fn c, b ->
      {c, Map.put(b, c, Map.get(b, c, 0) + 1)}
    end)
    bag
  end

  def common_characters(words) do
    common =
      # make multisets of the words' characters
      words |> Enum.map(fn word -> bag(word) end)
      # find the intersection of the multisets
      |> Enum.reduce(fn b, c ->
           # the function returns the smallest count
           Map.intersect(b, c, fn _k, v1, v2 -> min(v1, v2) end)
         end)
    # convert the map into a list of common characters
    {_, list} = common
      |> Map.keys
      |> Enum.map_reduce([], fn char, list ->
           count = Map.get(common, char)
           {char, list ++ List.duplicate(char, count)}
         end)
    list
  end

  def quoted_list(words) do
    words
    |> Enum.map(fn w -> "\"#{w}\"" end)
    |> Enum.join(", ")
  end

  def solution(words) do
    IO.puts("Input: @words = (#{quoted_list(words)})")
    common = common_characters(words)
    IO.puts("Output: = (#{quoted_list(common)})")
  end
end

IO.puts("Example 1:")
PWC.solution(["bella", "label", "roller"])

IO.puts("\nExample 2:")
PWC.solution(["cool", "lock", "cook"])

IO.puts("\nExample 3:")
PWC.solution(["hello", "world", "pole"])

IO.puts("\nExample 4:")
PWC.solution(["abc", "def", "ghi"])

IO.puts("\nExample 5:")
PWC.solution(["aab", "aac", "aaa"])
