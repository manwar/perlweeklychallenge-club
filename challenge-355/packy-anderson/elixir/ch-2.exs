#!/usr/bin/env elixir

defmodule PWC do
  def mountain_array(_, [first | ints]) when length(ints) == 1 do
    cond do
      first > hd(ints) -> "true"
      true -> "false"
    end
  end

  def mountain_array(direction, [first | ints]) do
    cond do
      # must be strictly greater than or strictly less than
      first == hd(ints) -> "false"

      # if we're going back down, elements
      # from here on out must be >
      direction == :down and first < hd(ints) -> "false"
      direction == :down -> mountain_array(direction, ints)

      # first is the peak, head back down
      first > hd(ints) -> mountain_array(:down, ints)
      true -> mountain_array(direction, ints)
    end
  end

  def mountain_array([first | ints]) do
    cond do
      # arr.length >= 3 (we pulled the firt elem off already)
      length(ints) < 2 -> "false"

      # first element < second element
      first > hd(ints) -> "false"

      # check the rest of the array
      true -> mountain_array(:up, ints)
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: " <> mountain_array(ints))
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 2:")
PWC.solution([0, 2, 4, 6, 4, 2, 0])

IO.puts("\nExample 3:")
PWC.solution([5, 4, 3, 2, 1])

IO.puts("\nExample 4:")
PWC.solution([1, 3, 5, 5, 4, 2])

IO.puts("\nExample 5:")
PWC.solution([1, 3, 2])

IO.puts("\nExample 6:")
PWC.solution([1, 5, 4, 3, 2, 1])
