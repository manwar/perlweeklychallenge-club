#!/usr/bin/env elixir

defmodule PWC do
  def traverseList([], _, _, largest, second), do:
    {largest, second}

  def traverseList([val | rest], i, ints, largest, second) do
    {largest, second} = cond do
      val >= Enum.at(ints, largest) ->
        second  = largest
        largest = i
        {largest, second}

      second == -1 || val > Enum.at(ints, second) ->
        second = i
        {largest, second}

      true -> {largest, second}
    end
    traverseList(rest, i+1, ints, largest, second)
  end

  def twiceLargest(ints) when length(ints) <= 1, do: -1

  def twiceLargest(ints) do
    {_, rest} = List.pop_at(ints, 0) # remove the first element
    {largest, second} = traverseList(rest, 1, ints, 0, -1)
    if Enum.at(ints, largest) >= 2 * Enum.at(ints, second) do
      largest
    else
      -1
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{ twiceLargest(ints) }")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 4, 1, 0])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3, 4])

IO.puts("\nExample 3:")
PWC.solution([1])

IO.puts("\nExample 4:")
PWC.solution([4, 2, 1])
