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
  @doc """
  Helper function to append the element "num"
  to a list "count" times.
  """
  def addToList(list, num, count) do
    {_, list} = Enum.map_reduce(
      1 .. count,
      list,
      fn n, acc -> {n, acc ++ [num]} end
    )
    list
  end

  # when we have exhausted list2, put the remaining elements
  # from list1 into the sorted list in numerical order
  def relativeSort([], bag1, sorted) do
    {_, sorted} = Enum.map_reduce(
      Enum.sort(Map.keys(bag1)),
      sorted,
      fn k, sorted ->
        { k, addToList(sorted, k, Map.get(bag1, k))}
      end
    )
    "(" <> Enum.join(sorted, ", ") <> ")"
  end

  # process list2 element by element, adding elements to
  # the sorted list as many times as they occur in list1
  def relativeSort([next | rest], bag1, sorted) do
    count = Map.get(bag1, next)
    relativeSort(
      rest,
      Map.delete(bag1, next),
      addToList(sorted, next, count)
    )
  end

  # process the two lists, check error conditions, then
  # recursively call relativeSort/3 to build the sorted output
  def relativeSort(list1, list2) do
    bag1 = Bag.from_enum(list1)
    bag2 = Bag.from_enum(list2)

    cond do
      Enum.any?(Map.values(bag2), fn x -> x != 1 end) ->
        "@list2 is not distinct"
      Enum.any?(Map.keys(bag2), fn k -> !Map.has_key?(bag1, k) end) ->
        "At least one element in @list2 is not in @list1"
      true ->
        relativeSort(list2, bag1, [])
    end
  end

  def solution(list1, list2) do
    IO.puts("Input: @list1 = (" <> Enum.join(list1, ", ") <> ")")
    IO.puts("       @list2 = (" <> Enum.join(list2, ", ") <> ")")
    IO.puts("Output: " <> relativeSort(list1, list2))
  end
end

IO.puts("Example 1:")
PWC.solution(
  [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
  [2, 1, 4, 3, 5, 6]
)

IO.puts("\nExample 2:")
PWC.solution(
  [3, 3, 4, 6, 2, 4, 2, 1, 3],
  [1, 3, 2]
)

IO.puts("\nExample 3:")
PWC.solution(
  [3, 0, 5, 0, 2, 1, 4, 1, 1],
  [1, 0, 3, 2]
)

IO.puts("\nError Condition 1:")
PWC.solution(
  [3, 0, 5, 0, 2, 1, 4, 1, 1],
  [1, 0, 3, 2, 0]
)

IO.puts("\nError Condition 2:")
PWC.solution(
  [3, 0, 5, 0, 2, 1, 4, 1, 1],
  [1, 0, 3, 2, 8]
)
