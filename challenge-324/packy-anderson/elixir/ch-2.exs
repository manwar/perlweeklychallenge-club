#!/usr/bin/env elixir

defmodule PWC do
  def powerSet([]), do: []

  def powerSet([i | rest]) do
    list = powerSet(rest)
    [[i] | Enum.reduce(list, list, &[[i | &1] | &2])]
  end

  def totalXOR([], sum), do: sum

  def totalXOR([set | rest], sum) do
    totalXOR(
      rest,
      sum + Enum.reduce(set, 0, &( Bitwise.bxor(&1, &2) ))
    )
  end

  def totalXOR(ints) do
    powerSet(ints) |> totalXOR(0)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{totalXOR(ints)}")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 3])

IO.puts("\nExample 2:")
PWC.solution([5, 1, 6])

IO.puts("\nExample 3:")
PWC.solution([3, 4, 5, 6, 7, 8])
