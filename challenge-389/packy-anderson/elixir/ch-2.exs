#!/usr/bin/env elixir

defmodule PWC do
  # base cases
  def is_zig_zag(nums) when length(nums) == 1, do: true
  def is_zig_zag(nums) when length(nums) == 2, do:
    Enum.at(nums, 0) != Enum.at(nums, 1)

  def is_zig_zag(nums) do
    # it's only ZigZag if the array is ZigZag before last elem
    if is_zig_zag(Enum.slice(nums, 0..length(nums)-2)) do
      (Enum.at(nums, -3) > Enum.at(nums, -2)
        and
       Enum.at(nums, -2) < Enum.at(nums, -1))
      or
      (Enum.at(nums, -3) < Enum.at(nums, -2)
        and
       Enum.at(nums, -2) > Enum.at(nums, -1))
    else
      false
    end
  end

  # pull elements off the front until it's ZigZag again
  def while_not_zig_zag([_ | current]) do
    if is_zig_zag(current) do
      current
    else
      while_not_zig_zag(current)
    end
  end

  def longest_zig_zag(nums) do
    {_, longest} =
    Enum.reduce(0..length(nums)-1, {[], []},
      fn i, {current, longest} ->
        # put the $i-th element onto the current subset
        current = current ++ [Enum.at(nums, i)]
        if is_zig_zag(current) do
          if length(current) > length(longest) do
            {current, current}
          else
            {current, longest}
          end
        else
          { while_not_zig_zag(current), longest}
        end
      end)
    { length(longest), longest }
  end

  def solution(nums) do
    IO.puts("Input: @nums = (" <> Enum.join(nums, ", ") <> ")")
    {len, longest} = longest_zig_zag(nums)
    IO.puts("Output: #{len}\n")
    IO.puts("ZigZag subarray: (" <> Enum.join(longest, ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([9, 4, 2, 10, 7, 8, 8, 1, 9])

IO.puts("\nExample 2:")
PWC.solution([1, 7, 4, 9, 2, 5])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 4:")
PWC.solution([4, 4, 4])

IO.puts("\nExample 5:")
PWC.solution([10, 20, 15, 12, 18])
