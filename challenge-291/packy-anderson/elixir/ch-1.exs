#!/usr/bin/env elixir

defmodule PWC do
  def leftSum(_ints, i) when i == 0, do: 0
  def leftSum(ints, i) do
    ints |> Enum.slice(0..i-1) |> Enum.sum
  end

  def rightSum(ints, i) when i >= length(ints), do: 0
  def rightSum(ints, i) do
    ints |> Enum.slice(i+1..-1//1) |> Enum.sum
  end

  def middleIndex(ints, i) when i >= length(ints), do: -1
  def middleIndex(ints, i) do
    if leftSum(ints, i) == rightSum(ints, i) do
      i
    else
      middleIndex(ints, i+1)
    end
  end

  def middleIndex(ints) do
    middleIndex(ints, 0)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    IO.puts("Output: #{ middleIndex(ints) }")
  end
end

IO.puts("Example 1:")
PWC.solution([2, 3, -1, 8, 4])

IO.puts("\nExample 2:")
PWC.solution([1, -1, 4])

IO.puts("\nExample 3:")
PWC.solution([2, 5])

IO.puts("\nExample 4:")
PWC.solution([0, 5])
