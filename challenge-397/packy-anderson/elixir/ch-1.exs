#!/usr/bin/env elixir

defmodule PWC do
  def increment_if_in(pos, arr) do
    if Enum.member?(arr, pos),
      do: increment_if_in(pos+1, arr),
      else: pos
  end

  def absent_smallest_positive(arr) do
    avg = Enum.sum(arr) / length(arr)
    avg
    |> Float.ceil(0)    # smallest float (to 0 places) > num
    |> trunc            # convert to integer
    |> then(& if &1 < 1, do: 1, else: &1) # require positive num
    |> then(& if &1 == avg, do: &1 + 1, else: &1) # require > num
    |> increment_if_in(arr) # require num not in array
  end

  def solution(arr) do
    IO.puts("Input: @arr = (" <> Enum.join(arr, ", ") <> ")")
    IO.puts("Output: #{absent_smallest_positive(arr)}")
  end
end

IO.puts("Example 1:")
PWC.solution([1, 2, 4, 5, 6])

IO.puts("\nExample 2:")
PWC.solution([-5, -2, -1, 3])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 3])

IO.puts("\nExample 4:")
PWC.solution([2, 3, 7, 8])

IO.puts("\nExample 5:")
PWC.solution([1, 1, 1, 10])
