#!/usr/bin/env elixir

defmodule PWC do
  def isSimilar(d1, d2) do
    (Enum.at(d1,0) == Enum.at(d2,0)
     &&
     Enum.at(d1,1) == Enum.at(d2,1))
    ||
    (Enum.at(d1,0) == Enum.at(d2,1)
     &&
     Enum.at(d1,1) == Enum.at(d2,0))
  end

  def similarDominos(dominos) do
    last = length(dominos)-1
    # convert list to map
    dominos = 0..last |> Stream.zip(dominos) |> Enum.into(%{})
    data = %{
      count: 0,
      similar: [],
      i_sim: [],
      matched: %{}
    }
    {_, data} = Enum.map_reduce(0..last-1, data,
    fn i, data ->
      data = if ! data[:matched][i] do
        {_, data} = Enum.map_reduce(i+1..last, data,
        fn j, data ->
          data = if ! data[:matched][j] do
            data = if isSimilar(dominos[i], dominos[j]) do
              data = if ! data[:matched][i] do
                data
                |> Map.put(:count, data[:count] + 1)
                |> Map.put(:matched, Map.put(data[:matched], i, true))
                |> Map.put(:i_sim, data[:i_sim] ++ ["$dominos[#{i}]"])
              else
                data
              end
              data
              |> Map.put(:count, data[:count] + 1)
              |> Map.put(:matched, Map.put(data[:matched], j, true))
              |> Map.put(:i_sim, data[:i_sim] ++ ["$dominos[#{j}]"])
            else
              data
            end
            data
          else
            data
          end
          {j, data}
        end)
        data
      else
        data
      end
      data = if length(data[:i_sim]) > 0 do
        data
        |> Map.put(:similar, data[:similar] ++ [ data[:i_sim] ])
        |> Map.put(:i_sim, [])
      else
        data
      end
      {i, data}
    end)
    explain = "Similar Dominos: " <> case length(data[:similar]) do
      0 -> "none"
      1 -> Enum.join(List.first(data[:similar]), ", ")
      _ ->
        s = Enum.map(data[:similar], fn s ->
          "[" <> Enum.join(s, ", ") <> "]"
        end)
        "\n + " <> Enum.join(s, "\n + ")
    end
    {data[:count], explain}
  end

  def solution(dominos) do
    dom = Enum.map(dominos, fn d ->
      "[" <> Enum.join(d, ", ") <> "]"
    end)
    IO.puts("Input: @dominos = (" <> Enum.join(dom, ", ") <> ")")
    {count, explain} = similarDominos(dominos)
    IO.puts("Output: #{count}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution([[1, 3], [3, 1], [2, 4], [6, 8]])

IO.puts("\nExample 2:")
PWC.solution([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]])

IO.puts("\nExample 3:")
PWC.solution([[1, 2], [3, 4], [2, 1], [4, 3], [1, 2]])
