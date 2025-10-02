# Task 2: Reverse Prefix
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str and a character in the given string, $char.
# Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.
# 
# Example 1
# Input: $str = "programming", $char = "g"
# Output: "gorpmming"
# 
# Reverse of prefix "prog" is "gorp".
# 
# Example 2
# Input: $str = "hello", $char = "h"
# Output: "hello"
# 
# Example 3
# Input: $str = "abcdefghij", $char = "h"
# Output: "hgfedcbaj"
# 
# Example 4
# Input: $str = "reverse", $char = "s"
# Output: "srevere"
# 
# Example 5
# Input: $str = "perl", $char = "r"
# Output: "repl"

defmodule ReverseString do

  def splitStr(str, char) do
    s = String.split(str, char, parts: 2)
    String.reverse( Enum.at(s, 0) <> char ) <> Enum.at(s, 1)
  end

  def out(str, char) do
    IO.write( "'" <> str <> "' '" <> char <> "' -> ")
    IO.puts( splitStr(str, char) )
  end

end

str = "programming"
char = "g"
ReverseString.out( str, char )

str = "hello"
char = "h"
ReverseString.out( str, char )

str = "abcdefghij"
char = "h"
ReverseString.out( str, char )

str = "reverse"
char = "s"
ReverseString.out( str, char )

str = "perl"
char = "r"
ReverseString.out( str, char )
