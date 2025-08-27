#!/usr/bin/env elixir

defmodule PWC do
  def divides_unevenly(smallest, bag) do
    bag
    |> Map.values
    |> Enum.filter(fn v -> rem(v, smallest) != 0 end)
    |> length != 0
  end

  def find_smallest(smallest, _) when smallest <= 2,
    do: 2

  def find_smallest(smallest, bag) when smallest > 2 do
    # can we divide the list evenly into multiples
    # of the smallest group?
    if divides_unevenly(smallest, bag) do
      # no, let's divide it by 2 and try again
      find_smallest(trunc(smallest/2), bag)
    else
      smallest
    end
  end

  def render_groups(stream) do
    stream
    |> Enum.to_list
    |> Enum.map(fn l -> "(" <> Enum.join(l,",") <> ")" end)
    |> Enum.join(" ")
  end

  def equal_group(ints, bag) do
    # find the smallest number of instances of
    # an int in the list
    smallest = Map.values(bag) |> Enum.min |> find_smallest(bag)

    # make the groups and return the result
    if divides_unevenly(smallest, bag) do
      # we can't evenly divide by smallest, just
      # make a single group for each unique int
      {
        "false",
        ints |> Stream.chunk_by(&(&1)) |> render_groups
      }
    else
      # make groups of smallest
      {
        "true",
        ints |> Stream.chunk_every(smallest) |> render_groups
      }
    end
  end

  def equal_group(ints) do
    bag = Enum.frequencies(ints) # one line bag!
    if Enum.any?(Map.values(bag), fn v -> v < 2 end) do
      # if we don't have more than 2 instances of
      # a particular int, we can't make groups
      {"false", ""}
    else
      equal_group(ints, bag)
    end
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ",") <> ")")
    {result, groups} = equal_group(ints)
    IO.puts("Output: #{result}")
    if groups != "" do
      IO.puts("\nGroups: #{groups}")
    end
  end
end

IO.puts("Example 1:")
PWC.solution([1,1,2,2,2,2])

IO.puts("\nExample 2:")
PWC.solution([1,1,1,2,2,2,3,3])

IO.puts("\nExample 3:")
PWC.solution([5,5,5,5,5,5,7,7,7,7,7,7])

IO.puts("\nExample 4:")
PWC.solution([1,2,3,4])

IO.puts("\nExample 5:")
PWC.solution([8,8,9,9,10,10,11,11])

IO.puts("\nExample 6 (2a):")
PWC.solution([1,1,1,1,2,2,2,2,3,3])

IO.puts("\nExample 7 (2b):")
PWC.solution([1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3])

IO.puts("\nExample 8 (3a):")
PWC.solution([5,5,5,5,5,7,7,7,7,7,7])
