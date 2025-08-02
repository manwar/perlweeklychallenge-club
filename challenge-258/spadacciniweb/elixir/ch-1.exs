# Task 1: Count Even Digits Number
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a array of positive integers, @ints.
# 
# Write a script to find out how many integers have even number of digits.
# 
# Example 1
# Input: @ints = (10, 1, 111, 24, 1000)
# Output: 3
# 
# There are 3 integers having even digits i.e. 10, 24 and 1000.
# 
# Example 2
# Input: @ints = (111, 1, 11111)
# Output: 0
# 
# Example 3
# Input: @ints = (2, 8, 1024, 256)
# Output: 1

defmodule DigitsNumber do
  def even(ints) do
    Enum.filter(ints, fn x -> rem( String.length(Integer.to_string(x)), 2) == 0 end) |> Enum.count()
  end
  def out(ints) do
    IO.write( "(" <> Enum.join(ints, ", ") <> ") -> ")
    IO.puts( even(ints) )
  end
end

ints = [10, 1, 111, 24, 1000]
DigitsNumber.out(ints)

ints = [111, 1, 11111]
DigitsNumber.out(ints)

ints = [2, 8, 1024, 256]
DigitsNumber.out(ints)
