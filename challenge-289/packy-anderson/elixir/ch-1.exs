#!/usr/bin/env elixir

defmodule Bag do
  @moduledoc """
  Generates a Multiset/Bag implemented as a Map.

  https://en.wikipedia.org/wiki/Multiset
  """
  @moduledoc since: "1.0.0"

  @doc """
  Generates a Bag from an enum.
  """
  def from_enum(enum) do
    {_, bag} = Enum.map_reduce(enum, %{}, fn i, bag ->
      { i, Map.put(bag, i, Map.get(bag, i, 0) + 1) }
    end)
    bag
  end
end

defmodule PWC do
  def thirdMaximum(ints) do
    distinct = Bag.from_enum(ints) # get distinct integers
    if (length(Map.keys(distinct)) < 3) do
      # not enough values for a third max, return max
      Enum.max(Map.keys(distinct))
    else
      # sort and then get the third from the end
      Map.keys(distinct)
      |> Enum.sort(:desc)
      |> Enum.at(2)
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{ thirdMaximum(ints) }")
  end
end

IO.puts("Example 1:")
PWC.solution([5, 6, 4, 1])

IO.puts("\nExample 2:")
PWC.solution([4, 5])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 2, 3])
