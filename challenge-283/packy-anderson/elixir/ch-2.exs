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
  Return true if for every index i in the range 0 <= i < size
  of array, the digit i occurs exactly the $ints[$i] times in
  the given array, otherwise return false.
  """
  def digitCountValue(ints) do
    bag = makeBag(ints)
    results = Enum.map(0 .. length(ints)-1, fn i ->
      # return a tuple of {digit, occurrences, expected}
      { i, Map.get(bag, i, 0), Enum.at(ints, i) }
    end)
    explain = Enum.map(results, fn tuple ->
      digit  = elem(tuple, 0)
      occurs = elem(tuple, 1)
      times  = elem(tuple, 2)
      otimes = cond do
        occurs == 0 -> "0 times"
        occurs >= 2 -> "#{occurs} times"
        true        -> "1 time"
      end
      ttimes = cond do
        times == 0 -> "0 times"
        times >= 2 -> "#{times} times"
        true       -> "1 time"
      end
      if occurs == times do
        "$ints[#{digit}] = #{times}, the digit #{digit} " <>
        "occurs #{otimes}"
      else
        "$ints[#{digit}] = #{times}, the digit #{digit} " <>
        "occurs #{otimes} rather than #{ttimes}"
      end
    end)
    |> Enum.join("\n")
    passes = Enum.all?(results, fn tuple ->
      elem(tuple, 1) == elem(tuple, 2)
    end)
    |> to_string
    {passes, explain}
  end

  @doc """
  Function to print the input, invoke the solution code,
  and print the output.
  """
  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {passes, explain} = digitCountValue(ints)
    IO.puts("Output: " <> passes)
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 1, 0])

IO.puts("\nExample 2:")
PWC.solution([0, 3, 0])

IO.puts("\nExample 3:")
PWC.solution([0, 1, 2, 2])
