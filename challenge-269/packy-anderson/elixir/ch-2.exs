#!/usr/bin/env elixir

defmodule PWC do
  # when the list is empty, return the two distribution arrays
  def distributeElements([], arr1, arr2) do
    {arr1, arr2}
  end

  def distributeElements([i | ints], arr1, arr2) do
    {arr1, arr2} = case List.last(arr1) > List.last(arr2) do
      true  -> { arr1 ++ [i], arr2 }
      false -> { arr1, arr2 ++ [i] }
    end
    # recursively call distributeElements/3
    distributeElements(ints, arr1, arr2)
  end

  def distributeElements(ints) do
    # grab the first two elements off the given array
    # and put them in the two distribution arrays
    {arr1, ints} = Enum.split(ints, 1)
    {arr2, ints} = Enum.split(ints, 1)

    # call distributeElements/3 to distribute the rest
    {arr1, arr2} = distributeElements(ints, arr1, arr2)

    # concatenate the arrays together
    List.flatten(arr1, arr2)
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    out = distributeElements(ints)
    IO.puts("Output: (" <> Enum.join(out, ", ") <> ")" )
  end
end

IO.puts("Example 1:")
PWC.solution([2, 1, 3, 4, 5])

IO.puts("\nExample 2:")
PWC.solution([3, 2, 4])

IO.puts("\nExample 3:")
PWC.solution([5, 4, 3 ,8])
