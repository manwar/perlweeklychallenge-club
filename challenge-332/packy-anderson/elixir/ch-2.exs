#!/usr/bin/env elixir

defmodule PWC do
  def make_bag(list) do
    {_, bag} = Enum.map_reduce(list, %{}, fn i, bag ->
      { i, Map.put(bag, i, Map.get(bag, i, 0) + 1) }
    end)
    bag
  end

  def all_odd([]), do: "true"

  def all_odd([this | rest]) do
    if rem(this,2) == 0 do
      "false"
    else
      all_odd(rest)
    end
  end

  def odd_letters(str) do
    str |> String.graphemes |> make_bag |> Map.values |> all_odd
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: \"#{odd_letters(str)}\"")
  end
end

IO.puts("Example 1:")
PWC.solution("weekly")

IO.puts("\nExample 2:")
PWC.solution("perl")

IO.puts("\nExample 3:")
PWC.solution("challenge")
