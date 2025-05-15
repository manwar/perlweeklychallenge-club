#!/usr/bin/env elixir

defmodule PWC do
  defp counter(int, {pos, neg}) do
    {pos, neg} = cond do
      int > 0 -> {pos+1, neg  }
      int < 0 -> {pos,   neg+1}
      true    -> {pos,   neg  }
    end
    {int, {pos, neg}}
  end

  def maxCount(ints) do
    {_, {pos, neg}} = Enum.map_reduce(ints, {0, 0}, &counter/2)
    max = Enum.max([pos, neg])
    {
      max,
      "There are #{pos} positive integers.\n" <>
      "There are #{neg} negative integers.\n" <>
      "The maximum between #{pos} and #{neg} is #{max}."
    }
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {max, explain} = maxCount(ints)
    IO.puts("Output: #{max}")
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([-3, -2, -1, 1, 2, 3])

IO.puts("\nExample 2:")
PWC.solution([-2, -1, 0, 0, 1])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 4])
