#!/usr/bin/env elixir

defmodule PWC do
  def min_abs_diff([], _, _, pairs), do:
    pairs |> Enum.join(", ")

  def min_abs_diff([current | ints], last, min_val, pairs) do
    diff = abs(current - last)
    pair = "[#{last}, #{current}]"
    { min_val, pairs } = cond do
      diff == min_val ->
        # same diff, add to list
        { min_val, pairs ++ [pair] }
      diff < min_val ->
        # start new list with this pair
        { diff, [pair] }
      true -> { min_val, pairs }
    end
    # process next pair
    min_abs_diff(ints, current, min_val, pairs)
  end

  def min_abs_diff(ints) do
    # sort so minimum difference items are next to each other
    ints = Enum.sort(ints)

    min_abs_diff(
      tl(ints),
      hd(ints),
      # start with the largest possible difference
      abs(Enum.at(ints,-1) - Enum.at(ints,0)),
      []
    )
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: " <> min_abs_diff(ints) )
  end
end

IO.puts("Example 1:")
PWC.solution([4, 2, 1, 3])

IO.puts("\nExample 2:")
PWC.solution([10, 100, 20, 30])

IO.puts("\nExample 3:")
PWC.solution([-5, -2, 0, 3])

IO.puts("\nExample 4:")
PWC.solution([8, 1, 15, 3])

IO.puts("\nExample 5:")
PWC.solution([12, 5, 9, 1, 15])
