#!/usr/bin/env elixir

defmodule PWC do
  def manhattan_distance(a, b) do
    {
      abs(Enum.at(a,0) - Enum.at(b,0)) +
      abs(Enum.at(a,1) - Enum.at(b,1)),
      "|#{Enum.at(a,0)} - #{Enum.at(b,0)}| + " <>
      "|#{Enum.at(a,1)} - #{Enum.at(b,1)}|"
    }
  end

  def format_point(p) do
    "[#{Enum.at(p, 0)}, #{Enum.at(p, 1)}]"
  end

  def is_valid(x, y, p) do
    Enum.at(p,0) == x or Enum.at(p,1) == y
  end

  def range(points), do: 0..length(points)-1

  def nvp(x, y, points, valid) do
    explanation = cond do
      map_size(valid) == length(points) ->
        "Valid points: all of them"
      true ->
        vpoints = Map.keys(valid)
               |> Enum.map(fn i -> Enum.at(points, i) end)
               |> Enum.map(fn p -> format_point(p) end)
        "Valid points: " <> Enum.join(vpoints, ", ")
    end

    # now find the distances from the valid points to (x,y)
    explanation = explanation <> "\n\nManhattan distances:\n"
    {_, {dist, explanation}} = Enum.map_reduce(
      range(points), {%{}, explanation},
      fn i, {dist, explanation} ->
        {dist, explanation} = if Map.get(valid, i) do
          {d, e} = manhattan_distance([x, y], Enum.at(points,i))
          explanation = explanation <> "    " <>
                        format_point(Enum.at(points,i)) <>
                        " => #{e} => #{d}\n"
          # add the index to a list for this distance
          # get the existing list in d, default to empty list
          dist = Map.put(dist, d, Map.get(dist, d, []) ++ [i])
          {dist, explanation}
        else
          {dist, explanation}
        end
        {i, {dist, explanation}}
      end
    )

    # the minimum key in the dist map is the minimum distance
    min_val = Enum.min(Map.keys(dist))

    # label the minimum value list so its easier to use
    min_list = Map.get(dist, min_val)

    # pick the lowest index from the min distance array
    i = Enum.at(min_list, 0)

    explanation = explanation <> "\n" <> cond do
      length(min_list) == 1 ->
        point = format_point(Enum.at(points,i))
        "Closest valid point is #{point} at index #{i}."
      length(min_list) < map_size(valid) ->
        tie_list = Enum.join(min_list, " and ")
        "Tie between index #{tie_list}, " <>
        "pick the smaller index: #{i}."
      true ->
        "All tie, return the one with the lowest index: #{i}."
    end

    {i, explanation}
  end

  def nvp(x, y, points) do
    # find the "valid" points
    {_, valid} = Enum.map_reduce(
      range(points), %{},
      fn i, valid ->
        valid = if is_valid(x, y, Enum.at(points, i)) do
          Map.put(valid, i, 1)
        else
          valid
        end
        {i, valid}
      end
    )

    if map_size(valid) == 0 do
      { -1, "No point shares x or y with (#{x}, #{y})." }
    else
      nvp(x, y, points, valid)
    end
  end

  def solution(x, y, points) do
    str_list = Enum.map(points, fn p -> format_point(p) end)
            |> Enum.join(", ")
    IO.puts("Input: $x = #{x}, $y = #{y}, @points (#{str_list})")
    {output, explain} = nvp(x, y, points)
    IO.puts("Output: #{output}")
    IO.puts("\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]])

IO.puts("\nExample 2:")
PWC.solution(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]])

IO.puts("\nExample 3:")
PWC.solution(1, 1, [[2, 2], [3, 3], [4, 4]])

IO.puts("\nExample 4:")
PWC.solution(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]])

IO.puts("\nExample 5:")
PWC.solution(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]])
