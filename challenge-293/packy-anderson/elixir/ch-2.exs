#!/usr/bin/env elixir

defmodule PWC do
  def isBoomerang(points) do
    # map how many distinct points we have
    {_, distinct} = Enum.map_reduce(points, %{}, fn p, distinct ->
      {p, Map.put(distinct, Enum.join(p, ","), true)}
    end)

    # extract the coordinates
    x0 = points |> Enum.at(0) |> Enum.at(0)
    x1 = points |> Enum.at(1) |> Enum.at(0)
    x2 = points |> Enum.at(2) |> Enum.at(0)
    y0 = points |> Enum.at(0) |> Enum.at(1)
    y1 = points |> Enum.at(1) |> Enum.at(1)
    y2 = points |> Enum.at(2) |> Enum.at(1)

    cond do
      # check that we have three distinct points
      distinct |> Map.keys |> length < 3 -> false
      # is this a straight line on the X axis?
      x0 == x1 == x2 -> false
      # is this a straight line on the Y axis?
      y0 == y1 == y2 -> false
      # straight line if the diffs are the same
      (x1 - x0 == x2 - x1) and (y1 - y0 == y2 - y1) -> false

      true -> true
    end
  end

  def solution(points) do
    pt = Enum.map(points, fn p ->
      "[" <> Enum.join(p, ", ") <> "]"
    end)
    IO.puts("Input: @points = (" <> Enum.join(pt, ", ") <> ")")
    IO.puts("Output: #{ isBoomerang(points) }")
  end
end

IO.puts("Example 1:")
PWC.solution([[1, 1], [2, 3], [3,2]])

IO.puts("\nExample 2:")
PWC.solution([[1, 1], [2, 2], [3, 3]])

IO.puts("\nExample 3:")
PWC.solution([[1, 1], [1, 2], [2, 3]])

IO.puts("\nExample 4:")
PWC.solution([[1, 1], [1, 2], [1, 3]])

IO.puts("\nExample 5:")
PWC.solution([[1, 1], [2, 1], [3, 1]])

IO.puts("\nExample 6:")
PWC.solution([[0, 0], [2, 3], [4, 5]])
