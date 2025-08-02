#!/usr/bin/env elixir

defmodule PWC do
  def reverseEquals(source, target, i, j) do
    reversed = [] ++ if i > 0 do
      Enum.slice(source, 0 .. i-1)
    else
      []
    end
    reversed = reversed ++ Enum.reverse(Enum.slice(source, i..j))
    reversed = reversed ++ if j < length(source)-1 do
      Enum.slice(source, j+1 .. length(source)-1)
    else
      []
    end
    cond do
      reversed == target ->
        { true, "#{i}-#{j}" }
      # we've reached the end of the nested loops,
      # so there's no solution
      i == length(source)-2 and j == length(source)-1 ->
        { false, "" }
      # we're at the last j value, so let's increment i
      # and set j = i+1
      j == length(source)-1 ->
        reverseEquals(source, target, i+1, i+2)
      # just increment j
      true ->
        reverseEquals(source, target, i, j+1)
    end
  end

  def reverseEquals(source, target)
    when length(source) != length(target), do: { false, "" }

  def reverseEquals(source, target)
    when source == target, do: { true, "" }

  def reverseEquals(source, target) do
    reverseEquals(source, target, 0, 1)
  end

  def solution(source, target) do
    IO.puts("Input: @source = (" <> Enum.join(source, ", ") <> ")")
    IO.puts("       @target = (" <> Enum.join(target, ", ") <> ")")
    {equals, elements} = reverseEquals(source, target)
    IO.puts("Output: #{equals}")
    if elements do
      IO.puts("\nReverse elements: #{elements}")
    end
  end
end

IO.puts("Example 1:")
PWC.solution([3, 2, 1, 4], [1, 2, 3, 4])

IO.puts("\nExample 2:")
PWC.solution([1, 3, 4], [4, 1, 3])

IO.puts("\nExample 3:")
PWC.solution([2], [2])
