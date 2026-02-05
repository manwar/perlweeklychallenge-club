#!/usr/bin/env elixir

defmodule PWC do
  def digital_root(int, persistence \\ 0) do
    cond do
      int < 10 -> {persistence, int}
      true -> digital_root(
        Integer.digits(int) |> Enum.sum, persistence + 1
      )
    end
  end

  def solution(int) do
    IO.puts("Input: $int = #{int}")
    {persistence, root} = digital_root(int)
    IO.puts("Output: Persistence  = #{persistence}")
    IO.puts("        Digital Root = #{root}")
  end
end

IO.puts("Example 1:")
PWC.solution(38)

IO.puts("\nExample 2:")
PWC.solution(7)

IO.puts("\nExample 3:")
PWC.solution(999)

IO.puts("\nExample 4:")
PWC.solution(1999999999)

IO.puts("\nExample 5:")
PWC.solution(101010)
