# Task 2: Sum of Values
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @int and an integer $k.
# 
# Write a script to find the sum of values whose index binary representation has exactly $k number of 1-bit set.
# 
# Example 1
# Input: @ints = (2, 5, 9, 11, 3), $k = 1
# Output: 17
# 
# Binary representation of index 0 = 0
# Binary representation of index 1 = 1
# Binary representation of index 2 = 10
# Binary representation of index 3 = 11
# Binary representation of index 4 = 100
# 
# So the indices 1, 2 and 4 have total one 1-bit sets.
# Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17
# 
# Example 2
# Input: @ints = (2, 5, 9, 11, 3), $k = 2
# Output: 11
# 
# Example 3
# Input: @ints = (2, 5, 9, 11, 3), $k = 0
# Output: 2

defmodule SumOfValues do

  def sum_filter(ints, k) do
    rejected_indices = indexes(ints, k)
    ints
    |> Stream.with_index()
    |> Stream.reject(fn {_item, index} -> index in rejected_indices end)
    |> Stream.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def indexes(ints, k) do
    0..length(ints)
    |> Stream.filter(fn x -> Enum.sum( Integer.digits(x, 2) ) != k end)
  end

  def out(ints, k) do
    IO.write( "(" <> Enum.join(ints, ", ") <> ") #{k} -> ")
    IO.puts( sum_filter(ints, k) )
  end

end

ints = [2, 5, 9, 11, 3]
k = 1
SumOfValues.out(ints, k)

ints = [2, 5, 9, 11, 3]
k = 2
SumOfValues.out(ints, k)

ints = [2, 5, 9, 11, 3]
k = 0
SumOfValues.out(ints, k)
