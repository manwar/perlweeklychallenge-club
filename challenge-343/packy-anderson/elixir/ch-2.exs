#!/usr/bin/env elixir

defmodule PWC do
  def stronger(i, j, grid) do
    cond do
      grid |> Enum.at(i) |> Enum.at(j) == 1 -> i
      grid |> Enum.at(i) |> Enum.at(j) == 0 -> j
    end
  end

  def reduce_fn(row, {best, max, team}) do
    sum = Enum.sum(row)
    {best, max} = cond do
      sum > max ->
        {[team], sum}
      sum == max ->
        {best ++ [team], max}
      true ->
        {best, max}
    end
    {row, {best, max, team+1}}
  end

  def champion_team(grid) do
    {_, {best, _, _}} =
      Enum.map_reduce(grid, {[], 0, 0}, &reduce_fn/2)
    if length(best) == 1 do
      best |> List.first
    else
      stronger(List.first(best), List.last(best), grid)
    end
  end

  def format_matrix(grid) do
    grid
    |> Enum.map(fn row -> Enum.join(row, ", ") end)
    |> Enum.join(",\n               ")
  end

  def solution(grid) do
    IO.puts("Input: @grid = #{format_matrix(grid)}")
    IO.puts("Output: #{champion_team(grid)}")
  end
end

IO.puts("Example 1:")
PWC.solution([
  [0, 1, 1],
  [0, 0, 1],
  [0, 0, 0]
])

IO.puts("\nExample 2:")
PWC.solution([
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [1, 1, 0, 0],
  [1, 1, 1, 0]
])

IO.puts("\nExample 3:")
PWC.solution([
  [0, 1, 0, 1],
  [0, 0, 1, 1],
  [1, 0, 0, 0],
  [0, 0, 1, 0]
])

IO.puts("\nExample 4:")
PWC.solution([
  [0, 1, 1],
  [0, 0, 0],
  [0, 1, 0]
])

IO.puts("\nExample 5:")
PWC.solution([
  [0, 0, 0, 0, 0],
  [1, 0, 0, 0, 0],
  [1, 1, 0, 1, 1],
  [1, 1, 0, 0, 0],
  [1, 1, 0, 1, 0]
])
