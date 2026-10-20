#!/usr/bin/env elixir

defmodule PWC do
  def finishing_order(order, friends) do
    Enum.filter(order, & Enum.member?(friends, &1) )
  end

  def solution(order, friends) do
    IO.puts("Input: @order   = (" <> Enum.join(order, ", ") <> ")")
    IO.puts("       @friends = (" <> Enum.join(friends, ", ") <> ")")
    IO.puts("Output: (" <> Enum.join(finishing_order(order, friends), ", ") <> ")")
  end
end

IO.puts("Example 1:")
PWC.solution([3, 1, 4, 2, 5],[1, 2, 4])

IO.puts("\nExample 2:")
PWC.solution([5, 4, 3, 2, 1],[1, 3, 5])

IO.puts("\nExample 3:")
PWC.solution([2, 4, 1, 3],[1, 2, 3, 4])

IO.puts("\nExample 4:")
PWC.solution([4, 1, 3, 2],[3])

IO.puts("\nExample 5:")
PWC.solution([1, 3, 2, 6, 5, 4],[1, 2, 3])
