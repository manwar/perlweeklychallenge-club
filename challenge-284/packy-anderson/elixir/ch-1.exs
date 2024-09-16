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
  def luckyInteger(ints) do
    bag = Bag.from_enum(ints)
    # filter for keys that match their frequency
    keys = Enum.filter(Map.keys(bag), fn k -> k == Map.get(bag, k) end)
    if length(keys) == 0 do
      -1 # return -1 if no lucky int was found
    else
      # return the largest lucky int
      keys |> Enum.sort |> List.last
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: " <> to_string(luckyInteger(ints)) )
  end
end

IO.puts("Example 1:")
PWC.solution([2, 2, 3, 4])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 2, 3, 3, 3])

IO.puts("\nExample 3:")
PWC.solution([1, 1, 1, 3])
