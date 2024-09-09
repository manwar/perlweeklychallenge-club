#!/usr/bin/env elixir

defmodule PWC do
  # establish the values of the coins
  @coin_types %{ 50 => "HD", 25 => "Q", 10 => "D", 5 => "N", 1 => "P" }

  # make a sorted list of coin values
  @coin_values @coin_types |> Map.keys |> Enum.sort |> Enum.reverse

  def formatCoin(coin, count) do
    if count > 1 do
      "#{to_string(count)}#{coin}"
    else
      coin
    end
  end

  def joinCoins(x, y) do
    Enum.join([ x, y ], " + ")
  end

  def addCoins(count, coin, amount, _, output) when amount == 0 do
    output ++ [ formatCoin(coin, count) ]
  end

  def addCoins(count, coin, amount, value, output) do
    # make a recursive call to get the combinations
    # for that remaining amount, excluding any coins
    # of equal or greater value to $value
    {_, output} = makeChange(amount, value)
    |> Enum.map_reduce(output, fn combo, output ->
      this_coin = formatCoin(coin, count)
      {
        combo,
        output ++ [ joinCoins(this_coin, combo) ]
      }
    end)
    output
  end

  def makeChange([value | remaining], amount, exclude, output)
      when (value > amount) or (exclude > 0 and value >= exclude) do
    # if this type of coin is worth more than the total,
    # we can't use it OR
    # if we're excluding this coin value or greater, skip it
    makeChange(remaining, amount, exclude, output)
  end

  def makeChange([value], amount, _, output)
      when value == 1 do
    # we're adding pennies
    output ++ [ formatCoin("P", amount) ]
  end

  def makeChange([value | remaining], amount, exclude, output) do
    coin = @coin_types |> Map.get(value) # get the coin name
    # loop from max number of this coin we can use down to 1
    {_, output} = 1 .. Integer.floor_div(amount, value)
    |> Enum.reverse
    |> Enum.map_reduce(output,
      fn count, output2 ->
        # figure out how much change we need after we've used
        # $count many of coin $coin
        left = amount - (count * value)
        { count, addCoins(count, coin, left, value, output2) }
      end)
    makeChange(remaining, amount, exclude, output)
  end

  def makeChange(amount, exclude \\ 0) do
    makeChange(@coin_values, amount, exclude, [])
  end

  def solution(amount) do
    IO.puts("Input: @amount = #{ amount }")
    ways = makeChange(amount)
    IO.puts("Output: #{ length(ways) }")
    Enum.map_reduce(ways, 0, fn c, i ->
      i = i + 1
      IO.puts("#{i}: #{c}")
      { c, i }
    end)
  end
end

IO.puts("Example 1:")
PWC.solution(9)

IO.puts("\nExample 2:")
PWC.solution(15)

IO.puts("\nExample 3:")
PWC.solution(100)
