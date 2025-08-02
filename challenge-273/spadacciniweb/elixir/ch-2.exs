# Task 2: B After A
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str.
# Write a script to return true if there is at least one b, and no a appears after the first b.
# 
# Example 1
# Input: $str = "aabb"
# Output: true
# 
# Example 2
# Input: $str = "abab"
# Output: false
# 
# Example 3
# Input: $str = "aaa"
# Output: false
# 
# Example 4
# Input: $str = "bbb"
# Output: true

defmodule Position do

  def first_b(str) do
    case Regex.run(~r/b/, str, return: :index) do
      nil -> nil
      out -> out |> Enum.fetch!(0) |> elem(0)
    end
  end

  def last_a(str, pos) do
    case Regex.run(~r/a/, str, offset: pos, return: :index) do
      nil -> IO.puts( "true" )
      _   -> IO.puts( "false" )
    end 
  end

  def out(str) do
    IO.write( str <> " -> " )
    #IO.inspect( first_b(str) )
    case first_b(str) do
      nil -> IO.puts( "false" )
      out -> last_a(str, out)
    end
  end

end

str = "aabb"
Position.out(str)

str = "abab"
Position.out(str)

str = "aaa"
Position.out(str)

str = "bbb"
Position.out(str)
