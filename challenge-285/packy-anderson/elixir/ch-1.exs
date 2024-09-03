#!/usr/bin/env elixir

defmodule PWC do
  def noConnection(routes) do
    starts = routes
    |> Enum.map(fn x -> List.first(x) end)
    |> MapSet.new
    ends   = routes
    |> Enum.map(fn x -> List.last(x) end)
    |> MapSet.new
    noConnection = MapSet.difference(ends, starts)
    cond do
      MapSet.size(noConnection) == 0 ->
        "no terminal destinations"
      MapSet.size(noConnection) > 1 ->
        "multiple terminal destinations"
      true ->
        noConnection |> MapSet.to_list |> List.first
    end
  end

  def tupleJoin(list) do
    list
    |> Enum.map(fn x -> "[#{List.first(x)}, #{List.last(x)}]" end)
    |> Enum.join(", ")
  end

  def solution(routes) do
    IO.puts("Input: @routes = (#{ tupleJoin(routes) })")
    IO.puts("Output: #{noConnection(routes)}")
  end
end

IO.puts("Example 1:")
PWC.solution([["B","C"], ["D","B"], ["C","A"]])

IO.puts("\nExample 2:")
PWC.solution([["A","Z"], ])

IO.puts("\nBad Input: multiple terminal destination")
PWC.solution([["A","B"], ["C", "D"]])

IO.puts("\nBad Input: no terminal destinations")
PWC.solution([["A","Z"], ["Z", "A"]])
