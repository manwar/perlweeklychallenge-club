#!/usr/bin/env elixir

defmodule PWC do
  def straightLine(point_list) do
    {a, point_list} = List.pop_at(point_list, 0)
    {b, point_list} = List.pop_at(point_list, 0)
    {c, _}          = List.pop_at(point_list, 0)
    (
      (Enum.at(a,0) - Enum.at(b,0)) *
      (Enum.at(b,1) - Enum.at(c,1))
      ==
      (Enum.at(b,0) - Enum.at(c,0)) *
      (Enum.at(a,1) - Enum.at(b,1))
    )
  end

  def solution(point_list) do
    {_, list} = Enum.map_reduce(point_list, [],
      fn p, list ->
        {p, list ++ ["[#{Enum.at(p,0)}, #{Enum.at(p,1)}]"]}
      end
    )
    IO.puts("Input: @ints = (" <> Enum.join(list, ", ") <> ")")
    IO.puts("Output: #{straightLine(point_list)}")
  end
end

IO.puts("Example 1:")
PWC.solution([[2, 1], [2, 3], [2, 5]])

IO.puts("\nExample 2:")
PWC.solution([[1, 4], [3, 4], [10, 4]])

IO.puts("\nExample 3:")
PWC.solution([[0, 0], [1, 1], [2, 3]])

IO.puts("\nExample 4:")
PWC.solution([[1, 1], [1, 1], [1, 1]])

IO.puts("\nExample 5:")
PWC.solution([[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]])
