# Task 2: Replace Digits
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an alphanumeric string, $str, where each character is either a letter or a digit.
# Write a script to replace each digit in the given string with the value of the previous letter plus (digit) places.
# 
# Example 1
# Input: $str = 'a1c1e1'
# Ouput: 'abcdef'
# 
# shift('a', 1) => 'b'
# shift('c', 1) => 'd'
# shift('e', 1) => 'f'
# 
# Example 2
# Input: $str = 'a1b2c3d4'
# Output: 'abbdcfdh'
# 
# shift('a', 1) => 'b'
# shift('b', 2) => 'd'
# shift('c', 3) => 'f'
# shift('d', 4) => 'h'
# 
# Example 3
# Input: $str = 'b2b'
# Output: 'bdb'
# 
# Example 4
# Input: $str = 'a16z'
# Output: 'abgz'

defmodule ReplaceDigits do

  def transform(mychar, v) do
    <<c::utf8>> = mychar
    <<c + String.to_integer( v )::utf8>>
  end

  def translate(str) do
    Enum.to_list(0..String.length(str)-1)
    |> Enum.map(fn i -> case Regex.match?(~r/[0-9]/, String.at(str, i)) do
                          true  -> transform( String.at(str, i-1), String.at(str, i) )
                          false -> String.at(str, i)
                        end
                end)
    |> Enum.join("")
  end

  def out(str) do
    translate(str)
    IO.puts( "'#{str}' -> '#{translate(str)}'" )
  end

end

str = "a1c1e1";
ReplaceDigits.out(str);

str = "a1b2c3d4"
ReplaceDigits.out(str);

str = "b2b"
ReplaceDigits.out(str);

str = "a16z"
ReplaceDigits.out(str);
