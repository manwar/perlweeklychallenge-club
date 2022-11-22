#!/usr/bin/env ruby

=begin

  AUTHOR: Robert DiCicco

  DATE: 2022-11-21

  Challenge 192 Binary Flip ( Ruby )



  You are given a positive integer, $n.



  Write a script to find the binary flip.

  Example 1



  Input: $n = 5

  Output: 2



  First find the binary equivalent of the given integer, 101.

  Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.

  So Binary 010 => Decimal 2.



=end



ns = [5,4,6];



ns.each do |n|

  out = []

  binvals = []

  puts "Input: $n = #{n}"

  binvals = sprintf("%B", n).to_s

  (0..2).each do |v|

    if binvals[v] == '0'

      out.push('1')

    elsif binvals[v] == '1'

      out.push('0')

    else

      next

   end

  end

  puts "Output: #{out.join.to_i(2)}"

  puts " "

end



=begin

SAMPLE OUTPUT



ruby .\BinaryFlip.rb



Input: $n = 5

Output: 2



Input: $n = 4

Output: 3



Input: $n = 6

Output: 1



=end
