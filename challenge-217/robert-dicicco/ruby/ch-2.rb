#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-15
Challenge 217 Max Number ( Ruby )
---------------------------------------
=end

list = [[5,11,4,1,2],[31, 2, 4,10],[10,3,2],[1, 23],[1,10]];
max = 0

list.each do |lst|
    puts("Input: @list = #{lst}")
    ln = lst.length()
    lst.permutation(ln) do |item|
        n = (item.join).to_i
        if n > max
            max = n
        end
    end
    puts("Output: #{max}")
    puts("")
    max = 0
end

=begin
---------------------------------------
SAMPLE OUTPUT
ruby MaxNumber.rb
Input: @list = [5, 11, 4, 1, 2]
Output: 542111

Input: @list = [31, 2, 4, 10]
Output: 431210

Input: @list = [10, 3, 2]
Output: 3210

Input: @list = [1, 23]
Output: 231

Input: @list = [1, 10]
Output: 110
---------------------------------------
=end



