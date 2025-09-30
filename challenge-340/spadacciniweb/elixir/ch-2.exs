# Task 2: Ascending Numbers
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str, is a list of tokens separated by a single space. Every token is either a positive number consisting of digits 0-9 with no leading zeros, or a word consisting of lowercase English letters.
# Write a script to check if all the numbers in the given string are strictly increasing from left to right.
# 
# Example 1
# Input: $str = "The cat has 3 kittens 7 toys 10 beds"
# Output: true
# 
# Numbers 3, 7, 10 - strictly increasing.
# 
# Example 2
# Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
# Output: false
# 
# Example 3
# Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
# Output: true
# 
# Example 4
# Input: $str = 'Bob has 10 cars 10 bikes'
# Output: false
# 
# Example 5
# Input: $str = 'Zero is 0 one is 1 two is 2'
# Output: true

defmodule AscendingNumbers do

  def capture_numbers(str) do
    Regex.scan(~r/\d+/, str)
    |> List.flatten()
  end

  def check_ordered(str) do
    capture_numbers(str)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 1, :discard) 
    |> Enum.all?(fn [x,y] -> y > x end)
  end

  def out(str) do
    IO.write( "'" <> str <> "' -> ")
    IO.puts( check_ordered(str) )
  end

end

str = "The cat has 3 kittens 7 toys 10 beds"
AscendingNumbers.out( str )

str = "Alice bought 5 apples 2 oranges 9 bananas"
AscendingNumbers.out( str )

str = "I ran 1 mile 2 days 3 weeks 4 months"
AscendingNumbers.out( str )

str = "Bob has 10 cars 10 bikes"
AscendingNumbers.out( str )

str = "Zero is 0 one is 1 two is 2"
AscendingNumbers.out( str )
