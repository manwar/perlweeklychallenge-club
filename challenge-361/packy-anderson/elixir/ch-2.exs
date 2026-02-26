#!/usr/bin/env elixir

defmodule PWC do
  def celebrity(party) do
    n = length(party)
    {knows, known_by} =
    Enum.reduce(0..n-1, {%{}, %{}}, fn i, {k, kb} ->
      Enum.reduce(0..n-1, {k, kb}, fn j, {k, kb} ->
        val = party |> Enum.at(i) |> Enum.at(j)
        k   = Map.update(k,  i, val, &(&1 + val))
        kb  = Map.update(kb, j, val, &(&1 + val))
        {k, kb}
      end)
    end)
    Enum.reduce(0..n-1, -1, fn i, def ->
      if Map.get(knows,i) == 0 and Map.get(known_by,i) == n-1,
        do:   i,
        else: def
    end)
  end

  def format_matrix(grid, indent \\ 18) do
    grid
    |> Enum.map(fn row -> Enum.join(row, ", ") end)
    |> Enum.map(fn row -> "[" <> row <> "]" end)
    |> Enum.join(",\n" <> String.duplicate(" ", indent))
  end

  def solution(party) do
    IO.puts("Input: @party = [")
    IO.puts("                  #{format_matrix(party)}")
    IO.puts("                ]")
    IO.puts("Output: #{celebrity(party)}")
  end
end

IO.puts("Example 1:")
PWC.solution([
  [0, 0, 0, 0, 1, 0],  # 0 knows 4
  [0, 0, 0, 0, 1, 0],  # 1 knows 4
  [0, 0, 0, 0, 1, 0],  # 2 knows 4
  [0, 0, 0, 0, 1, 0],  # 3 knows 4
  [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
  [0, 0, 0, 0, 1, 0],  # 5 knows 4
])

IO.puts("\nExample 2:")
PWC.solution([
  [0, 1, 0, 0],  # 0 knows 1
  [0, 0, 1, 0],  # 1 knows 2
  [0, 0, 0, 1],  # 2 knows 3
  [1, 0, 0, 0]   # 3 knows 0
])

IO.puts("\nExample 3:")
PWC.solution([
  [0, 0, 0, 0, 0],  # 0 knows NOBODY
  [1, 0, 0, 0, 0],  # 1 knows 0
  [1, 0, 0, 0, 0],  # 2 knows 0
  [1, 0, 0, 0, 0],  # 3 knows 0
  [1, 0, 0, 0, 0]   # 4 knows 0
])

IO.puts("\nExample 4:")
PWC.solution([
  [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
  [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
  [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
  [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
  [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
  [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
])

IO.puts("\nExample 5:")
PWC.solution([
  [0, 1, 1, 0],  # 0 knows 1 and 2
  [1, 0, 1, 0],  # 1 knows 0 and 2
  [0, 0, 0, 0],  # 2 knows NOBODY
  [0, 0, 0, 0]   # 3 knows NOBODY
])

IO.puts("\nExample 6:")
PWC.solution([
  [0, 0, 1, 1],  # 0 knows 2 and 3
  [1, 0, 0, 0],  # 1 knows 0
  [1, 1, 0, 1],  # 2 knows 0, 1 and 3
  [1, 1, 0, 0]   # 3 knows 0 and 1
])
