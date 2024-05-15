#!/usr/bin/env elixir

defmodule PWC do
  # if we only have one element, return false
  def bitwisePair([_first | []]), do: false

  def bitwisePair([first | ints]) do
    # bitwise OR the first element with
    # each of the remaining elements and
    # check if the result is even
    found_pair = for next <- ints,
      Bitwise.band(Bitwise.bor(first, next), 1) == 0, do: true

    # found_pair is either a list of true values
    # or an empty list
    if List.first(found_pair) do
      List.first(found_pair)
    else
      # search the remaining list for pairs
      bitwisePair(ints)
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: " <> to_string(bitwisePair(ints)))
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 2:")
PWC.solution([2, 3, 8, 16])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 5, 7, 9])
