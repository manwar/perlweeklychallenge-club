#!/usr/bin/env elixir

defmodule PWC do
  defp map_reduce_func(y, {x, minDiff, madList}) do
    diff = abs(x - y)
    {minDiff, madList} = cond do
      diff > minDiff ->
        {minDiff, madList} # no change
      diff == minDiff ->
        # add [x,y] to the current list
        {minDiff, madList ++ [ Enum.sort([x, y]) ]}
      diff < minDiff ->
        # we found a new min!
        # make [x,y] the start of new list
        {diff, [ Enum.sort([x, y]) ]}
    end
    {y, {x, minDiff, madList}}
  end

  def mad([], _, madList), do: madList

  def mad([x | ints], minDiff, madList) do
    {_, {_, minDiff, madList}} = Enum.map_reduce(
      ints, {x, minDiff, madList}, &map_reduce_func/2
    )
    mad(ints, minDiff, madList)
  end

  def mad(ints) do
    # return the list with the pairs sorted as well
    mad(ints, Enum.max(ints), [])
    |> Enum.sort(&(List.first(&1) <= List.first(&2)))
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    mad = mad(ints)
       |> Enum.map(
            fn x -> "[#{List.first(x)},#{List.last(x)}]" end
          )
    IO.puts("Output: " <> Enum.join(mad, ", "))
  end
end

IO.puts("Example 1:")
PWC.solution([4, 1, 2, 3])

IO.puts("\nExample 2:")
PWC.solution([1, 3, 7, 11, 15])

IO.puts("\nExample 3:")
PWC.solution([1, 5, 3, 8])
