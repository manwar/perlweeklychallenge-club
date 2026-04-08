#!/usr/bin/env elixir

defmodule PWC do
  def find_factors(number, [], factors) when number > 2, do:
    factors ++ [number]

  def find_factors(_, [], factors), do: factors

  def find_factors(number, [n | possible], factors) do
    if (rem(number, n) == 0) do
      find_factors(trunc(number / n), [n] ++ possible, factors ++ [n])
    else
      find_factors(number, possible, factors)
    end
  end

  def prime_factors(number, mode) do
    n = trunc(:math.sqrt(number))+1
    possible = [2] # if it's even, 2 is a factor
            ++ Enum.to_list(Range.new(3, n, 2)) # odd nums up to √number
    factors = find_factors(number, possible, [])
    if mode == 1 do
      factors |> length
    else
      factors |> Enum.uniq |> length
    end
  end

  def solution(number, mode) do
    IO.puts("Input: $number = #{number}")
    IO.puts("       $mode = #{mode}")
    IO.puts("Output: #{prime_factors(number, mode)}")
  end
end

IO.puts("Example 1:")
PWC.solution(100061, 0)

IO.puts("\nExample 2:")
PWC.solution(971088, 0)

IO.puts("\nExample 3:")
PWC.solution(63640, 1)

IO.puts("\nExample 4:")
PWC.solution(988841, 1)

IO.puts("\nExample 5:")
PWC.solution(211529, 0)
