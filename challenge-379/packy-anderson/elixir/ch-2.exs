#!/usr/bin/env elixir

defmodule PWC do
  def armstrong(_, limit, n, armstrong) when n > limit,
    do: armstrong

  def armstrong(base, limit, n, armstrong) do
    dig = Integer.digits(n, base)
    pow = length(dig)
    n2  = Enum.reduce(dig, 0, fn d, n2 ->
      n2 + (d ** pow)
    end)
    armstrong = if n == n2 do
      armstrong ++ [n]
    else
      armstrong
    end
    armstrong(base, limit, n+1, armstrong)
  end

  def armstrong(base, limit) do
    armstrong(base, limit, 0, [])
  end

  def solution(base, limit) do
    IO.puts("Input: $base = #{base}, $limit = #{limit}")
    list = armstrong(base, limit) |> Enum.join(", ")
    IO.puts("Output: (#{list})")
  end
end

IO.puts("Example 1:")
PWC.solution(10, 1000)

IO.puts("\nExample 2:")
PWC.solution(7, 1000)

IO.puts("\nExample 3:")
PWC.solution(16, 1000)
