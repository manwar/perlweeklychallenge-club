#!/usr/bin/env elixir

defmodule PWC do
  def smaller_than([], _, out), do: out

  def smaller_than([i | rest], bag, out) do
    {_, count} = Enum.map_reduce(Map.keys(bag), 0,
      fn k, count ->
        cond do
          k <= i ->
            {k, count + Map.get(bag, k)}
          true ->
            {k, count}
        end
      end
    )
    smaller_than(rest, bag, out ++ [count - 1])
  end

  def smaller_than(num1) do
    bag = Enum.frequencies(num1)
    smaller_than(num1, bag, [])
  end

  def solution(num1) do
    IO.puts("Input: @ints = (" <> Enum.join(num1, ", ") <> ")")
    out = smaller_than(num1)
    IO.puts("Output: (" <> Enum.join(out, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([6, 5, 4, 8])

IO.puts("\nExample 2:")
PWC.solution([7, 7, 7, 7])

IO.puts("\nExample 3:")
PWC.solution([5, 4, 3, 2, 1])

IO.puts("\nExample 4:")
PWC.solution([-1, 0, 3, -2, 1])

IO.puts("\nExample 5:")
PWC.solution([0, 1, 1, 2, 0])
