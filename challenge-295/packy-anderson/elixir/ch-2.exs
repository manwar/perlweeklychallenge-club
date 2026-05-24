#!/usr/bin/env elixir

defmodule PWC do
  def might_as_well(i, max_steps, jumps, ints)
    when i + max_steps >= length(ints)-1, do: jumps

  def might_as_well(_, max_steps, _, _)
    when max_steps == 0, do: -1 # dead end

  def might_as_well(i, max_steps, jumps, ints) do
    min_steps = Enum.reduce(max_steps..1//-1, [],
      fn j, min_steps ->
        steps = might_as_well(i + j, jumps+1, ints)
        if steps == -1,
          do:   min_steps, # dead end
          else: min_steps ++ [steps]
      end)
    if length(min_steps) > 0, do: Enum.min(min_steps), else: -1
  end

  def might_as_well(i, jumps, ints) do
    max_steps = Enum.at(ints, i)
    might_as_well(i, max_steps, jumps, ints)
  end

  # we're already at the end
  def jump(ints) when length(ints) == 1, do: 0

  def jump(ints) do
    might_as_well(0, 1, ints)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{jump(ints)}")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 3, 1, 1, 4])

IO.puts("\nExample 2:")
PWC.solution([2, 3, 0, 4])

IO.puts("\nExample 3:")
PWC.solution([2, 0, 0, 4])

IO.puts("\nExample 4:")
PWC.solution([3, 0, 0, 4])

IO.puts("\nExample 5:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 6:")
PWC.solution([0])
