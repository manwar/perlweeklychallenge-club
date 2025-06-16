#!/usr/bin/env elixir

defmodule PWC do
  def consecutiveOne([], _, max_c), do: max_c

  def consecutiveOne([current | remaining], consecutive, max_c) do
    cond do
      current == 1 ->
        consecutiveOne(
          remaining, consecutive + 1,
          max(max_c, consecutive + 1)
        )
      true ->
        consecutiveOne(remaining, 0, max_c)
    end
  end

  def consecutiveOne(binary) do
    consecutiveOne(binary, 0, 0)
  end

  def solution(binary) do
    IO.puts("Input: @ints = (" <> Enum.join(binary, ", ") <> ")")
    IO.puts("Output: #{consecutiveOne(binary)}")
  end
end

IO.puts("Example 1:")
PWC.solution([0, 1, 1, 0, 1, 1, 1])

IO.puts("\nExample 2:")
PWC.solution([0, 0, 0, 0])

IO.puts("\nExample 3:")
PWC.solution([1, 0, 1, 0, 1, 1])

IO.puts("\nExample 4:")
PWC.solution([1, 1, 1, 0, 1, 1, 0])

IO.puts("\nExample 5:")
PWC.solution([1, 0, 1, 1, 0, 1, 0])
