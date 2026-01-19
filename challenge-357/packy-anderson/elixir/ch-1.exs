#!/usr/bin/env elixir

defmodule PWC do
  def sort_digits(digits, func) do
    digits |> Enum.sort(func) |> Enum.join |> String.to_integer
  end

  def zero_pad(digits) when length(digits) >= 4, do: digits
  def zero_pad(digits) do
    [0] ++ digits
  end

  def kaprekar_count(int, count \\ 0) do
    case int do
      0    -> -1    # sequence doesn't converge
      6174 -> count # sequence converged in this many iterations
      _    -> digits = Integer.digits(int) |> zero_pad
              num1   = digits |> sort_digits(&(&1 >= &2))
              num2   = digits |> sort_digits(&(&2 >= &1))
              diff   = num1 - num2
              kaprekar_count(diff, count + 1)
    end
  end

  def solution(int) do
    IO.puts("Input: $ints = #{int}")
    IO.puts("Output: #{kaprekar_count(int)}")
  end
end

IO.puts("Example 1:")
PWC.solution(3524)

IO.puts("\nExample 2:")
PWC.solution(6174)

IO.puts("\nExample 3:")
PWC.solution(9998)

IO.puts("\nExample 4:")
PWC.solution(1001)

IO.puts("\nExample 5:")
PWC.solution(9000)

IO.puts("\nExample 6:")
PWC.solution(1111)
