#!/usr/bin/env elixir

defmodule PWC do
  def sieve(n) do
    # so we always have enough primes, caclulate out to 2n
    n = n * 2
    # make a list of n true elements
    is_prime = Map.new(2..n, fn i -> {i, true} end)
    final = trunc(:math.sqrt(n))+1
    Enum.reduce(2..final, is_prime, fn i, is_prime ->
      if Map.get(is_prime, i) do
        Enum.reduce((i ** 2)..n//i, is_prime, fn j, is_prime ->
          Map.put(is_prime, j, false)
        end)
      else
        is_prime # already deemed not prime
      end
    end)
  end

  def prime_step(is_prime, ordsum, j) do
    cond do
      Map.get(is_prime, ordsum+j) or Map.get(is_prime, ordsum-j)
        -> j
      j < ordsum
        -> prime_step(is_prime, ordsum, j+1) # recusive call
      true
        -> -1 # we should never get here
    end
  end

  def prime_step(str) do
    ordsum = str |> String.to_charlist |> Enum.sum
    prime_step(sieve(ordsum), ordsum, 0)
  end

  def solution(str) do
    IO.puts("Input: $str = \"#{str}\"")
    IO.puts("Output: #{prime_step(str)}")
  end
end

IO.puts("Example 1:")
PWC.solution("hello")

IO.puts("\nExample 2:")
PWC.solution("football")

IO.puts("\nExample 3:")
PWC.solution("a")

IO.puts("\nExample 4:")
PWC.solution("challenge")

IO.puts("\nExample 5:")
PWC.solution("perl")
