#!/usr/bin/env elixir

defmodule PWC do
  def distinctAverages([], step, explain, averages),
    do: {explain, averages}

  def distinctAverages(nums, step, explain, averages) do
    {min, nums} = List.pop_at(nums, 0)
    {max, nums} = List.pop_at(nums, -1)
    avg = (min + max) / 2
    # since in Elixir, this will always produce a float,
    # we need to do a little more work to make sure avg is an
    # integer when it has no fractional component
    avg = cond do
      avg == trunc(avg) -> trunc(avg)
      true              -> avg
    end
    explain = explain <> "Step #{step}: Min = #{min}, "
    explain = explain <> "Max = #{max}, Avg = #{avg}\n"
    averages = averages |> Map.put(avg, 1)
    distinctAverages(nums, step+1, explain, averages)
  end

  def distinctAverages(nums) do
    {explain, averages} =
        distinctAverages(Enum.sort(nums), 1, "", %{})
    count = averages |> Map.keys |> length
    {
      count,
      explain <> "\nThe count of distinct average is #{count}."
    }
  end

  def solution(nums) do
    IO.puts("Input: @nums = (" <> Enum.join(nums, ", ") <> ")")
    {count, explain} = distinctAverages(nums)
    IO.puts("Output: #{count}\n\n#{explain}")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 4, 3, 5, 6])

IO.puts("\nExample 2:")
PWC.solution([0, 2, 4, 8, 3, 5])

IO.puts("\nExample 3:")
PWC.solution([7, 3, 1, 0, 5, 9])

IO.puts("\nExample 4:")
PWC.solution([1, 9, 2, 6, 3, 4])
