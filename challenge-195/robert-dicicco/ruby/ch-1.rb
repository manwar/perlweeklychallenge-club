#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2022-12-13

Challenge 195 Special Integers ( Ruby )

 

SAMPLE OUTPUT

 ruby .\SpecialIntegers.rb

Input: $n = 15

Output: 14

 

Input: $n = 35

Output: 32

------------------------------------------------

=end

def CheckUniqDigits(n)

  h1 = Hash.new

  arr = n.digits

  for onedig in arr

    h1.key?(onedig) ? (return 0) : (h1[onedig] = 1)

  end

  return 1

end

 

[15,35].each do |n|

  output = 0

  puts("Input: \$n = #{n}")

  for x in (1..n) do

    output += CheckUniqDigits(x)

  end

  print("Output: #{output}\n\n")

end
