#!/usr/bin/env elixir

defmodule PWC do
  def fractions(int) when int == 1, do: [ {1, 1} ]
  def fractions(int) do
    list   = [ {1, int}, {int,1} ]
    digits = if int == 2, do: [2], else: 2..(int-1)
    Enum.reduce(digits, list, fn digit, list ->
      cond do
        rem(int, digit) != 0 ->
          list ++ [ {digit, int}, {int, digit} ]
        true -> list
      end
    end) ++ fractions(int - 1)
  end

  def tuple_to_fraction({numerator, denominator}),
    do: numerator / denominator

  def tuple_to_fraction_str({numerator, denominator}),
    do: "#{numerator}/#{denominator}"

  def uniq_fractions(int) do
    fractions(int)
    |> Enum.sort_by(&tuple_to_fraction/1)
    |> Enum.map(&tuple_to_fraction_str/1)
    |> Enum.join(", ")
  end

  def solution(int) do
    IO.puts("Input: $int = #{int}")
    IO.puts("Output: " <> uniq_fractions(int))
  end
end

IO.puts("Example 1:")
PWC.solution(3)

IO.puts("\nExample 2:")
PWC.solution(4)

IO.puts("\nExample 3:")
PWC.solution(1)

IO.puts("\nExample 4:")
PWC.solution(6)

IO.puts("\nExample 5:")
PWC.solution(5)
