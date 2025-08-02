#!/usr/bin/env elixir

defmodule PWC do

  def solution(ints) do
    IO.puts("Input: @ints = (" <> Enum.join(ints, ", ") <> ")")
    {sign, explain} = PWC.productSign(ints)
    IO.puts("Output: " <> to_string(sign) )
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution()

IO.puts("\nExample 2:")
PWC.solution()

IO.puts("\nExample 3:")
PWC.solution()
