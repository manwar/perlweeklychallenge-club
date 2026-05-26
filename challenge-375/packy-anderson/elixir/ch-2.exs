#!/usr/bin/env elixir

defmodule PWC do
  def k_beauty(num, k) do
    numstr = num |> Integer.to_string
    Enum.reduce(0..(String.length(numstr) - k), 0, fn i, count ->
      sub = String.slice(numstr, i, k)
      if Integer.mod(num, String.to_integer(sub)) == 0 do
        count + 1
      else
        count
      end
    end)
  end

  def solution(num, k) do
    IO.puts("Input: $num = #{num}, $k = #{k}")
    IO.puts("Output: #{k_beauty(num, k)}")
  end
end

IO.puts("Example 1:")
PWC.solution(240, 2)

IO.puts("\nExample 2:")
PWC.solution(1020, 2)

IO.puts("\nExample 3:")
PWC.solution(444, 2)

IO.puts("\nExample 4:")
PWC.solution(17, 2)

IO.puts("\nExample 5:")
PWC.solution(123, 1)
