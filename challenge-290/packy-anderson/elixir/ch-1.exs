#!/usr/bin/env elixir

defmodule PWC do
  require Integer # so we can use is_odd/1 as function

  def doubleExist(ints) do
    iLoop(ints, 0)
  end

  def iLoop(ints, i) when i >= length(ints), do: {false, false}
  def iLoop(ints, i) do
    iVal = Enum.at(ints, i)
    # we can't use Enum functions in a guard,
    # so we need this test here
    {answer, explain} = if Integer.is_odd(iVal) do
      {false, false}
    else
      # start the j loop
      jLoop(ints, i, 0)
    end
    if answer do
      # found an answer, return it
      {answer, explain}
    else
      # go to the next possible i value
      iLoop(ints, i + 1)
    end
  end

  def jLoop(ints, _, j) when j >= length(ints), do: {false, false}
  # skip when i == j
  def jLoop(ints, i, j) when i == j, do: jLoop(ints, i, j + 1)
  def jLoop(ints, i, j) do
    iVal = Enum.at(ints, i)
    jVal = Enum.at(ints, j)
    if jVal * 2 == iVal do
      # we found an answer!
      {
        true,
        "For $i = #{i}, $j = #{j}\n" <>
        "$ints[$i] = #{iVal} => 2 * #{jVal} => " <>
        "2 * $ints[$j]"
      }
    else
      # go to the next possible j value
      jLoop(ints, i, j + 1)
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {answer, explain} = doubleExist(ints)
    IO.puts("Output: #{answer}")
    if explain do
      IO.puts("\n" <> explain)
    end
  end
end

IO.puts("Example 1:")
PWC.solution([6, 2, 3, 3])

IO.puts("\nExample 2:")
PWC.solution([3, 1, 4, 13])

IO.puts("\nExample 3:")
PWC.solution([2, 1, 4, 2])
