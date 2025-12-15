#!/usr/bin/env elixir

defmodule PWC do
  def arithmetic_progression([], _, _), do: true

  def arithmetic_progression([cur | ints], prev, diff) do
    cond do
      diff != cur - prev -> false
      true -> arithmetic_progression(ints, cur, diff)
    end
  end

  def arithmetic_progression(ints) do
    ints = Enum.sort(ints)
    {prev, ints} = {hd(ints), tl(ints)}
    diff = hd(ints) - prev # calc first difference
    arithmetic_progression(ints, prev, diff)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{arithmetic_progression(ints)}")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 3, 5, 7, 9])

IO.puts("\nExample 2:")
PWC.solution([9, 1, 7, 5, 3])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 4, 8, 16])

IO.puts("\nExample 4:")
PWC.solution([5, -1, 3, 1, -3])

IO.puts("\nExample 5:")
PWC.solution([1.5, 3, 0, 4.5, 6])
