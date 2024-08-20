#!/usr/bin/env elixir

defmodule PWC do
  @doc """
  Helper function that accepts a list and generates a Multiset/
  Bag implemented as a Map.

  https://en.wikipedia.org/wiki/Multiset
  """
  def makeBag(list) do
    {_, bag} = Enum.map_reduce(list, %{}, fn i, bag ->
      { i, Map.put(bag, i, Map.get(bag, i, 0) + 1) }
    end)
    bag
  end

  @doc """
  You are given an array of integers where every element
  appears more than once except one element.

  Find the one element that appears exactly one time.
  """
  def uniqueNumber(ints) do
    keys = ints
    |> makeBag
    |> Map.filter(fn {_, v} -> v == 1 end) # keys that occur once
    |> Map.keys # return just the keys from the map
    cond do
      Kernel.length(keys) == 0 ->
        "no element appears only once"
      Kernel.length(keys) > 1 ->
        "multiple elements appear only once"
      true ->
        keys |> List.first |> to_string
    end
  end

  @doc """
  Function to print the input, invoke the solution code,
  and print the output.
  """
  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: " <> uniqueNumber(ints) )
  end
end

IO.puts("Example 1:")
PWC.solution([3, 3, 1])

IO.puts("\nExample 2:")
PWC.solution([3, 2, 4, 2, 4])

IO.puts("\nExample 3:")
PWC.solution([1])

IO.puts("\nExample 4:")
PWC.solution([4, 3, 1, 1, 1, 4])

IO.puts("\nInvalid Input 1 (no element appears only once):")
PWC.solution([4, 1, 1, 1, 4])

IO.puts("\nInvalid Input 2 (multiple elements appear only once):")
PWC.solution([1, 2, 3, 4])
