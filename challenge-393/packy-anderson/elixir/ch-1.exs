#!/usr/bin/env elixir

defmodule PWC do
  def pythag_mult(_, sn, a, _, count) when a > sn, do: count

  def pythag_mult(n, sn, a, b, count) do
    c = :math.sqrt(a ** 2 + b ** 2)
    if b > n or c > n do
      # increment a, start b at a+1
      pythag_mult(n, sn, a+1, a+2, count)
    else
      count = if c == trunc(c), do: count+2, else: count
      # increment b
      pythag_mult(n, sn, a, b+1, count)
    end
  end

  def pythag_mult(n) do
    pythag_mult(n, trunc(:math.sqrt(n ** 2 / 2)), 1, 2, 0)
  end

  def solution(n) do
    IO.puts("Input: $n = #{n}")
    IO.puts("Output: #{pythag_mult(n)}")
  end
end

IO.puts("Example 1:")
PWC.solution(20)

IO.puts("\nExample 2:")
PWC.solution(7)

IO.puts("\nExample 3:")
PWC.solution(1)

IO.puts("\nExample 4:")
PWC.solution(15)

IO.puts("\nExample 5:")
PWC.solution(30)
