#!/usr/bin/env elixir

defmodule PWC do
  # get just the indices stored in the map of maps
  defp indicesInMap(mapping) do
    List.flatten( for i <- Map.values(mapping), do: MapSet.to_list(i) )
  end

  def fmtInts(ints) do
    "@ints = (" <> Enum.join(ints, ", ") <> ")"
  end

  def addToMap(mapping, intVal, i) do
    submap = MapSet.put(Map.get(mapping, intVal, MapSet.new()), i)
    Map.put(mapping, intVal, submap)
  end

  def removeFromMap(mapping, intVal, i) do
    submap = mapping
    |> Map.get(intVal, MapSet.new())
    |> MapSet.delete(i)
    if MapSet.size(submap) == 0 do
      Map.delete(mapping, intVal)
    else
      Map.put(mapping, intVal, submap)
    end
  end

  # Increments a value in a list at a given index
  def incrementAt(ints, index) do
    ints
    |> Enum.with_index() # produces tuples of {value, index}
    |> Enum.map(fn
      {val, ^index} -> val + 1 # ^ matches on index
      {val, _}      -> val
    end)
  end

  # just remove the old value from the map
  # if the new value is maxVal
  def reMap(mapping, value, maxVal, index) when value == maxVal do
    mapping |> removeFromMap(value - 1, index)
  end

  # if the number we incremented is less than the max,
  # put it back in the mapping
  def reMap(mapping, value, _, index) do
    mapping
    |> removeFromMap(value - 1, index)
    |> addToMap(value, index)
  end

  # stopping case
  defp equalize(params = %{indices: indices})
    when length(indices) == 0, do: params

  # level 2 case
  defp equalize(params = %{indices: indices, x: x, y: y})
    when length(indices) > 1 and x * 2 >= y do
    {i, indices} = List.pop_at(indices, 0)
    {j, _}       = List.pop_at(indices, 0)
    mapping = params[:mapping]
    steps   = params[:steps]
    ints    = params[:ints]

    # increment the values
    ints = incrementAt(ints, i)
    ints = incrementAt(ints, j)
    steps = steps ++ [
      "Level 2: i=#{i}, j=#{j}, so $ints[#{i}] += 1 and " <>
      "$ints[#{j}] += 1\n" <> fmtInts(ints)
    ]
    params = %{params | L2: params[:L2] + 1}

    mapping = reMap(mapping, Enum.at(ints, i), params[:maxVal], i)
    mapping = reMap(mapping, Enum.at(ints, j), params[:maxVal], j)
    params  = %{params |
      indices: indicesInMap(mapping),
      mapping: mapping,
      steps: steps,
      ints: ints
    }
    equalize(params)
  end

  # level 1 case
  defp equalize(params = %{indices: indices}) do
    {i, _} = List.pop_at(indices, 0)
    mapping = params[:mapping]
    steps   = params[:steps]
    ints    = params[:ints]

    # increment the values
    ints = incrementAt(ints, i)
    steps = steps ++ [
      "Level 1: i=#{i}, so $ints[#{i}] += 1\n" <>
      fmtInts(ints)
    ]
    params = %{params | L1: params[:L1] + 1}

    mapping = reMap(mapping, Enum.at(ints, i), params[:maxVal], i)
    params  = %{params |
      indices: indicesInMap(mapping),
      mapping: mapping,
      steps: steps,
      ints: ints
    }
    equalize(params)
  end

  # once the list of ints is empty, return the results
  defp makeMapping([], maxVal, mapping, _), do: {maxVal, mapping}

  # process the first int off the list and recurse to
  # process the rest
  defp makeMapping([intVal | ints], maxVal, mapping, index) do
    maxVal = Enum.max([intVal, maxVal])
    mapping = addToMap(mapping, intVal, index)
    makeMapping(ints, maxVal, mapping, index + 1)
  end

  defp inflectTimes(n) do
    case n do
      1 -> "time"
      _ -> "times"
    end
  end

  defp equalizeArray(ints, x, y) do
    {maxVal, mapping} = makeMapping(ints, -1, %{}, 0)
    # we don't need to operate on values already at the max
    mapping = Map.delete(mapping, maxVal)

    params = equalize(%{
      indices: indicesInMap(mapping),
      mapping: mapping,
      maxVal: maxVal,
      steps: [],
      ints: ints,
      L1: 0,
      L2: 0,
      x: x,
      y: y,
    })
    steps = params[:steps]
    l1    = params[:L1]
    l2    = params[:L2]

    cost = (l1 * x) + (l2 * y)
    operations = if l1 > 0 do
      [ "Level 1, #{l1} " <> inflectTimes(l1) ]
    else
      []
    end
    operations = if l2 > 0 do
      operations ++ [ "Level 2, #{l2} " <> inflectTimes(l2) ]
    else
      operations
    end
    steps = steps ++ [
      "We performed operation " <>
      Enum.join(operations, " and ") <>
      "\nSo the total cost would be " <>
      "(#{l1} × $x) + (#{l2} × $y) => " <>
      "(#{l1} × #{x}) + (#{l2} × #{y}) => #{cost}"
    ]
    { cost, Enum.join(steps, "\n\n") }
  end

  def solution(ints, x, y) do
    IO.puts("Input: " <> fmtInts(ints) <> ", $x = #{x}, $y = #{y}")
    {cost, steps} = equalizeArray(ints, x, y)
    IO.puts("Output: " <> to_string(cost) )
    IO.puts("\n" <> steps)
  end
end

IO.puts("Example 1:")
PWC.solution([4,1], 3, 2)

IO.puts("\nExample 2:")
PWC.solution([2, 3, 3, 3, 5], 2, 1)
