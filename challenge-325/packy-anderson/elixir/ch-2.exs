#!/usr/bin/env elixir

defmodule PWC do
  def finalPrice([], discounts), do: discounts

  def finalPrice([current | prices], discounts) do
    lower = Enum.find(prices, 0, fn p -> p <= current end)
    finalPrice(prices, discounts ++ [current - lower])
  end

  def finalPrice(prices) do
    finalPrice(prices, [])
  end

  def solution(prices) do
    price_list = "(" <> Enum.join(prices, ", ") <> ")"
    IO.puts("Input: @prices = #{price_list}")
    discounts = finalPrice(prices)
    discount_list = "(" <> Enum.join(discounts, ", ") <> ")"
    IO.puts("Output: #{discount_list}")
  end
end

IO.puts("Example 1:")
PWC.solution([8, 4, 6, 2, 3])

IO.puts("\nExample 2:")
PWC.solution([1, 2, 3, 4, 5])

IO.puts("\nExample 3:")
PWC.solution([7, 1, 1, 5])
