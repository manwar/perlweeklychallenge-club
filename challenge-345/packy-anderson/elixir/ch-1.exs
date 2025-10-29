#!/usr/bin/env elixir

defmodule PWC do
  def reduce_fn(i, {peaks, ints}) do
    cond do
      i != 0 && Enum.at(ints,i-1) > Enum.at(ints,i) ->
        {i, {peaks, ints}}
      i != length(ints) && Enum.at(ints,i+1) > Enum.at(ints,i) ->
        {i, {peaks, ints}}
      true ->
        {i, {peaks ++ [i], ints}}
    end
  end

  def peak_positions(ints) do
    {_, {peaks, _}} = 0..length(ints)-1
      |> Enum.to_list
      |> Enum.map_reduce({[], ints}, &reduce_fn/2)
    peaks
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    peaks = peak_positions(ints)
    IO.puts("Output: (" <> Enum.join(peaks, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 3, 2])

IO.puts("\nExample 2:")
PWC.solution([2, 4, 6, 5, 3])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 2, 4, 1])

IO.puts("\nExample 4:")
PWC.solution([5, 3, 1])

IO.puts("\nExample 5:")
PWC.solution([1, 5, 1, 5, 1, 5, 1])
