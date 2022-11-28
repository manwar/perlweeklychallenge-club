#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-28

Challenge 193 Binary String ( Ruby )

 

Write a script to find all possible binary numbers of size $n.

Example 1

 

Input: $n = 2

Output: 00, 11, 01, 10

 

Example 2

 

Input: $n = 3

Output: 000, 001, 010, 100, 111, 110, 101, 011

------------------------------------------------------

SAMPLE OUTPUT

ruby .\BinaryString.rb

Input: $n = 2

Output: 00 01 10 11

 

Input: $n = 3

Output: 000 001 010 011 100 101 110 111

 

Input: $n = 4

Output: 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111

=end

 

arr = [2,3,4]

 

arr.each do |n|

  puts "Input: \$n = #{n}";

  x = 0;

  print "Output: ";

  while 1==1

    str = sprintf("%0*b", n,x)

    if str.length > n

      break

    end

    print "#{str} "

    x += 1

  end

  print "\n\n"

end
