#!/usr/bin/env elixir

defmodule PWC do
  def duplicate_zeros(ints) do
    size = length(ints)
    {_, dest} = Enum.map_reduce(ints, [],
      fn i, dest ->
        case i do
          0 -> {i, dest ++ [0, 0]}
          _ -> {i, dest ++ [i]}
        end
      end
    )
    drop = size - length(dest)
    Enum.drop(dest, drop)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    duped = duplicate_zeros(ints)
    IO.puts("Output: (" <> Enum.join(duped, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 0, 2, 3, 0, 4, 5, 0])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 0])

IO.puts("\nExample 4:")
PWC.solution([0, 0, 1, 2])

IO.puts("\nExample 5:")
PWC.solution([1, 2, 0, 3, 4])
