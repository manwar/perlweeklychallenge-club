#!/usr/bin/env elixir

defmodule PWC do
  def zero_friend(nums) do
    nums |> Enum.map(fn n -> abs(n) end) |> Enum.min
  end

  def solution(nums) do
    IO.puts("Input: @nums = (" <> Enum.join(nums, ", ") <> ")")
    IO.puts("Output: #{zero_friend(nums)}")
  end
end

IO.puts("Example 1:")
PWC.solution([4, 2, -1, 3, -2])

IO.puts("\nExample 2:")
PWC.solution([-5, 5, -3, 3, -1, 1])

IO.puts("\nExample 3:")
PWC.solution([7, -3, 0, 2, -8])

IO.puts("\nExample 4:")
PWC.solution([-2, -5, -1, -8])

IO.puts("\nExample 5:")
PWC.solution([-2, 2, -4, 4, -1, 1])
