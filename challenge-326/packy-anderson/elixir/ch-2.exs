#!/usr/bin/env elixir

defmodule PWC do
  def decompress([], out), do: out

  def decompress(ints, out) do
    {i, ints} = List.pop_at(ints, 0)
    {j, ints} = List.pop_at(ints, 0)
    decompress(ints, out ++ List.duplicate(j, i))
  end

  def decompress(ints) do
    decompress(ints, [])
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    out = decompress(ints)
    IO.puts("Output: (" <> Enum.join(out, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 3, 2, 4])

IO.puts("\nExample 2:")
PWC.solution([1, 1, 2, 2])

IO.puts("\nExample 3:")
PWC.solution([3, 1, 3, 2])
