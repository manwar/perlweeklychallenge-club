#!/usr/bin/env elixir

defmodule PWC do
  def permutations([]), do: [[]]

  def permutations(list) do
    for head <- list, rest <- permutations(list -- [head]),
      do: [head|rest]
  end

  def formation(source, target) do
    source = Enum.map(source, fn s -> Enum.join(s, "") end)
    target = Enum.join(target)
    {_, result} = Enum.map_reduce(
      permutations(source),
      "false",
      fn perm, result ->
        {
          perm,
          cond do
            Enum.join(perm) == target -> "true"
            true -> result
          end
        }
      end
    )
    result
  end

  def solution(source, target) do
    arr = Enum.map(
      source, fn s -> "[" <> Enum.join(s, ",") <> "]" end
    )
    IO.puts("Input: @source = (" <> Enum.join(arr, ", ") <> ")")
    IO.puts("       @target = (" <> Enum.join(target, ", ") <> ")")
    IO.puts("Output: #{formation(source, target)}")
  end
end

IO.puts("Example 1:")
PWC.solution([[2,3], [1], [4]], [1, 2, 3, 4])

IO.puts("\nExample 2:")
PWC.solution([[1,3], [2,4]], [1, 2, 3, 4])

IO.puts("\nExample 3:")
PWC.solution([[9,1], [5,8], [2]], [5, 8, 2, 9, 1])

IO.puts("\nExample 4:")
PWC.solution([[1], [3]], [1, 2, 3])

IO.puts("\nExample 5:")
PWC.solution([[7,4,6]], [7,4,6])
