#!/usr/bin/env elixir

defmodule PWC do
  def isStrongPair(x, y) do
    diff = abs(x - y)
    0 < diff and diff < min(x, y)
  end

  def findStrongPairs([], strong), do: strong

  def findStrongPairs([x | rest], strong) do
    strongY = Enum.filter(rest, fn y -> isStrongPair(x, y) end)
    strong = strong ++ Enum.map(strongY, fn y -> "(#{x}, #{y})" end)
    findStrongPairs(rest, strong)
  end

  def strongPairs(ints) do
    ints = ints
    |> Enum.uniq
    |> Enum.sort
    strong = findStrongPairs(ints, [])
    { length(strong), Enum.join(strong, ", ") }
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {count, explain} = strongPairs(ints)
    IO.puts("Output: " <> to_string(count) )
    IO.puts("\nStrong Pairs: " <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 2:")
PWC.solution([5, 7, 1, 7])
