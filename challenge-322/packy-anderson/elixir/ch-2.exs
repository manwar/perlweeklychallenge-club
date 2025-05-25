#!/usr/bin/env elixir

defmodule PWC do
  defp makeRankMap(i, {rank, rankMap}) do
    cond do
      not Map.has_key?(rankMap, i) ->
        rank = rank + 1
        {i, { rank, Map.put_new(rankMap, i, rank)} }
      true ->
        {i, { rank, rankMap } }
    end
  end

  def rankArray(ints) do
    {_, {_, rankMap}} = Enum.map_reduce(
      Enum.sort(ints), {0, %{}}, &makeRankMap/2
    )
    Enum.map(ints, fn i -> Map.get(rankMap, i) end)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    ranks = rankArray(ints)
    IO.puts("Output: (" <> Enum.join(ranks, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([55, 22, 44, 33])

IO.puts("\nExample 2:")
PWC.solution([10, 10, 10])

IO.puts("\nExample 3:")
PWC.solution([5, 1, 1, 4, 3])
