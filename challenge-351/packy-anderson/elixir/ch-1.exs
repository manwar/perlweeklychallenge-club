#!/usr/bin/env elixir

defmodule PWC do
  def special_average(ints) do
    min  = Enum.min(ints) # ok, using built-in functions to
    max  = Enum.max(ints) # find min/max rather than a loop
    ints = Enum.filter(ints, fn i -> i != min and i != max end)
    if length(ints) == 0 do
      0
    else
      trunc(Enum.sum(ints) / length(ints))
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{special_average(ints)}")
  end
end

IO.puts("Example 1:")
PWC.solution([8000, 5000, 6000, 2000, 3000, 7000])

IO.puts("\nExample 2:")
PWC.solution([100_000, 80_000, 110_000, 90_000])

IO.puts("\nExample 3:")
PWC.solution([2500, 2500, 2500, 2500])

IO.puts("\nExample 4:")
PWC.solution([2000])

IO.puts("\nExample 5:")
PWC.solution([1000, 2000, 3000, 4000, 5000, 6000])
