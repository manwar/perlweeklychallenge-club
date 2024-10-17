#!/usr/bin/env elixir

defmodule PWC do
# factorial calculation
  def factorial(n) when n < 2, do: 1
  def factorial(n), do: n * factorial(n - 1)

  def combinations(n, k) do
    trunc(factorial(n) / ( factorial(k) * factorial(n - k) ))
  end

  def format_number(n, parts) when n == "" do
    Enum.join(parts, ",")
  end
  def format_number(n, parts) do
    parts = [String.slice(n, -3..-1) | parts]
    format_number(String.slice(n,0..-4//1), parts)
  end
  def format_number(n) do
    format_number(Integer.to_string(n), [])
  end

  def pad9(s) do
    String.pad_leading(s, 9)
  end

  def solution() do
    IO.puts("1. How many different 5-card hands can be dealt?")
    possible_hands = combinations(52, 5)
    IO.puts("#{format_number(possible_hands)}\n")

    IO.puts("2. How many different hands of each of the 10 ranks can be dealt?")

    royalFlushes    = combinations(4, 1)
    straightFlushes = combinations(9, 1) * combinations(4, 1)
    fourOfAKinds    = combinations(13, 1) * combinations(48, 1)
    fullHouses      = combinations(13, 1) * combinations(4, 3)
                    * combinations(12, 1) * combinations(4, 2)
    flushes         = (combinations(13, 5) - 10)
                    * combinations(4, 1)
    straights       = combinations(10, 1) * (4 ** 5) - straightFlushes - royalFlushes
    threeOfAKinds   = combinations(13, 1) * combinations(4, 3)
                    * combinations(48, 2) - fullHouses
    twoPair         = combinations(13, 2) * (combinations(4, 2) ** 2)
                    * combinations(44, 1)
    onePair         = combinations(13, 1) * combinations(4, 2)
                    * combinations(12, 3) * combinations(4, 1) ** 3
    highCard        = (combinations(13, 5) - 10)
                    * (combinations(4, 1) ** 5 - 4)

    total = royalFlushes + straightFlushes + fourOfAKinds +
            fullHouses + flushes + straights + threeOfAKinds +
            twoPair + onePair + highCard

    IO.puts("Royal Flush:     #{ pad9(format_number(royalFlushes)) }")
    IO.puts("Straight Flush:  #{ pad9(format_number(straightFlushes)) }")
    IO.puts("Four of a Kind:  #{ pad9(format_number(fourOfAKinds)) }")
    IO.puts("Full House:      #{ pad9(format_number(fullHouses)) }")
    IO.puts("Flush:           #{ pad9(format_number(flushes)) }")
    IO.puts("Straight:        #{ pad9(format_number(straights)) }")
    IO.puts("Three of a Kind: #{ pad9(format_number(threeOfAKinds)) }")
    IO.puts("Two Pair:        #{ pad9(format_number(twoPair)) }")
    IO.puts("One Pair:        #{ pad9(format_number(onePair)) }")
    IO.puts("High Card:       #{ pad9(format_number(highCard)) }")
    IO.puts("--------------------------")
    IO.puts("Total:           #{ pad9(format_number(total)) }")
  end
end

PWC.solution()
