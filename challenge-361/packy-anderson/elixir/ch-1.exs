#!/usr/bin/env elixir

defmodule PWC do
  def largest_fibo_le(i, x, y) when y > i, do: x
  def largest_fibo_le(i, x, y) do
    largest_fibo_le(i, y, x + y)
  end
  def largest_fibo_le(i), do: largest_fibo_le(i, 0, 1)

  def zeckendorf(int) do
    # the largest element is the first number
    # in the Zeckendorf form
    z = [ largest_fibo_le(int) ]
    if hd(z) == int do
      z
    else
      # if we need more elements, use recursion to find them
      z ++ zeckendorf(int - hd(z)) |> List.flatten
    end
  end

  def solution(int) do
    IO.puts("Input: $int = #{int}")
    z = zeckendorf(int)
    IO.puts("Output: " <> Enum.join(z, ",") )
    IO.puts("\n#{int} => "  <> Enum.join(z, " + ") )
  end
end

IO.puts("Example 1:")
PWC.solution(4)

IO.puts("\nExample 2:")
PWC.solution(12)

IO.puts("\nExample 3:")
PWC.solution(20)

IO.puts("\nExample 4:")
PWC.solution(96)

IO.puts("\nExample 5:")
PWC.solution(100)
