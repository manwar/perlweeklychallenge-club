#!/usr/bin/env elixir

defmodule PWC do
  def int_join(ints, joiner), do: Enum.join(ints, joiner)

  def subDiff(ints) do
    element_sum = ints |> Enum.sum
    digits      = ints
                |> Enum.join
                |> String.codepoints
                |> Enum.map(fn i -> String.to_integer(i) end)
    digit_sum   = digits |> Enum.sum
    abs_diff    = abs(element_sum - digit_sum)
    int_list    = int_join(ints,   " + ")
    digit_list  = int_join(digits, " + ")
    {
      abs_diff,
      "Element sum: #{int_list} => #{element_sum}\n" <>
      "Digit sum:   #{digit_list} => #{digit_sum}\n" <>
      "Absolute difference: | #{element_sum} - #{digit_sum} |" <>
      " => #{abs_diff}"
    }
  end

  def solution(ints) do
    IO.puts("Input: @ints = (" <> int_join(ints, ", ") <> ")")
    {diff, explain} = subDiff(ints)
    IO.puts("Output: " <> to_string(diff) )
    IO.puts("\n" <> explain)
  end
end

IO.puts("Example 1:")
PWC.solution([1, 23, 4, 5])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 3:")
PWC.solution([1, 2, 34])
