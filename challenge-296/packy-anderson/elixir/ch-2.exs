#!/usr/bin/env elixir

defmodule PWC do
  def loopThroughMatches([], %{
    ints: ints, unused: unused, sides: sides
  } = data) do
    # return if we didn't use any matches,
    # or we've used ALL the matches
    if length(ints) == length(unused) or length(unused) == 0 do
      if length(sides) == 4 do # did we build 4 sides?
        {"True", sides}
      else
        {"False", '-'}
      end
    else
      # move the unused matches back to the list
      data = data
      |> Map.put(:ints, unused)
      |> Map.put(:unused, [])
      # loop through the remaining matches
      loopThroughMatches(unused, data)
    end
  end

  def loopThroughMatches([match | remaining], %{
    unused: unused, sideLen: sideLen, sides: sides
  } = data) do
    # this match can be added to other matches to make a side
    data = if match + Enum.sum(List.last(sides)) <= sideLen do
      # add to the matches for this side
      this_side = List.last(sides) ++ [ match ]
      # put this side back in the sides list
      sides = List.replace_at(sides, -1, this_side)
      # if we've made a complete side, and we have < 4 sides
      sides =
      if Enum.sum(this_side) == sideLen and length(sides) < 4 do
        sides ++ [ [] ] # add a new empty side
      else
        sides
      end
      Map.put(data, :sides, sides)
    else
      unused = unused ++ [ match ] # save match for later
      Map.put(data, :unused, unused)
    end
    loopThroughMatches(remaining, data)
  end

  def canBuildSquare(ints, sideLen) do
    data = %{
      ints: ints,
      unused: [],
      sideLen: sideLen,
      sides: [ [] ] # start with one empty side
    }
    loopThroughMatches(ints, data)
  end

  def canBuildSquare(ints) do
    # find the length of the sides of a square
    sideLen = Enum.sum(ints) / 4

    # sort the matches in descending length
    ints = Enum.sort(ints, &(&1 >= &2))

    {result, sides} = cond do
      # sides aren't integer length
      sideLen != Float.floor(sideLen) ->
        {"False", '-'}

      # if the longest match is longer than the side length,
      # we can't build a square
      List.first(ints) > sideLen ->
        {"False", '-'}

      # build sides from the matches
      true -> canBuildSquare(ints, sideLen)
    end

    {
      result,
      if result == "True" do
        Enum.map(sides, fn matches ->
          Enum.join(matches, "+")
        end)
        |> Enum.join(", ")
      else
        sides
      end
    }
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {result, sides} = canBuildSquare(ints)
    IO.puts("Output: #{result}")
    IO.puts("Sides: #{sides}")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 2, 2, 1])

IO.puts("\nExample 2:")
PWC.solution([2, 2, 2, 4])

IO.puts("\nExample 3:")
PWC.solution([2, 2, 2, 2, 4])

IO.puts("\nExample 4:")
PWC.solution([3, 4, 1, 4, 3, 1])

IO.puts("\nExample 5:")
PWC.solution([3, 4, 2, 4, 3])
