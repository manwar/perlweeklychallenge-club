# Task 1: Percentage of Character
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str and a character $char.
# Write a script to return the percentage, nearest whole, of given character in the given string.
# 
# Example 1
# Input: $str = "perl", $char = "e"
# Output: 25
# 
# Example 2
# Input: $str = "java", $char = "a"
# Output: 50
# 
# Example 3
# Input: $str = "python", $char = "m"
# Output: 0
# 
# Example 4
# Input: $str = "ada", $char = "a"
# Output: 67
# 
# Example 5
# Input: $str = "ballerina", $char = "l"
# Output: 22
# 
# Example 6
# Input: $str = "analitik", $char = "k"
# Output: 13

defmodule Percentage do

  def freq(str, char) do
    String.split(str, "", trim: true)
    |> Enum.frequencies
    |> Map.get(char)
  end

  def out(str, char) do
    IO.write( str <> " " <> char <> " -> ")
    case freq(str, char) do
        nil -> IO.puts "0"
        x -> IO.puts( x / String.length(str)*100 |> round )
    end
  end

end

str = "perl"; char = "e";
Percentage.out(str, char)

str = "java"; char = "a";
Percentage.out(str, char)

str = "python"; char = "m";
Percentage.out(str, char)

str = "ada"; char = "a";
Percentage.out(str, char)

str = "ballerina"; char = "l";
Percentage.out(str, char)

str = "analitik"; char = "k";
Percentage.out(str, char)
