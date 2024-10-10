#!/usr/bin/env elixir

defmodule PWC do
  def sumDigits(num) do
    {_, data} = num
    |> Integer.to_string # turn number into string
    |> String.codepoints # break into chars
    |> Enum.map(fn d -> String.to_integer(d) end) # convert to int
    |> Enum.map_reduce(%{ sum: 0 }, fn digit, data ->
      { digit, Map.put(data, :sum, digit + data[:sum])}
    end)
    data[:sum]
  end

  def luhnCheck?(num) do
    digits = num
    |> String.codepoints # break into chars
    |> Enum.filter(fn d -> Regex.match?(~r/\d/, d) end) # just numeric
    |> Enum.map(fn d -> String.to_integer(d) end) # convert to int
    |> Enum.reverse # reverse the digits

    data = %{
      multiplier: 1, # we'll alternate between 2 & 1
      sum: 0 # let's add the numbers as we process them
    }
    alternate = [0, 2, 1] # trick for alternating between 2 & 1
    {_, data} =
      Enum.map_reduce(digits, data, fn digit, data ->
        multiplier = data[:multiplier]
        product = digit * multiplier
        data = data
        |> Map.put(:multiplier, Enum.at(alternate, multiplier)) # alternate the multiplier
        |> Map.put(:sum, data[:sum] + sumDigits(product))
        { product, data }
      end)
    Kernel.rem(data[:sum], 10) == 0
  end

  def solution(num) do
    IO.puts("Input: \"#{num}\"")
    IO.puts("Output: #{ luhnCheck?(num) }")
  end
end

IO.puts("Example 1:")
PWC.solution("17893729974")

IO.puts("\nExample 2:")
PWC.solution("4137 8947 1175 5904")

IO.puts("\nExample 3:")
PWC.solution("4137 8974 1175 5904")
