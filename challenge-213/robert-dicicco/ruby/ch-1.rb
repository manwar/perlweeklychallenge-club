#!/usr/bin/env ruby
=begin
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-17
Challenge 213 Fun Sort ( Ruby )
-----------------------------------
=end

mylists = [[1,2,3,4,5,6],[1,2],[1]]

mylists.each do |arr|
    puts("Input: @list = #{arr}")
    evens = arr.find_all {|i|  i % 2 == 0 }
    odds =  arr.find_all {|i|  i % 2 == 1 }
    res = evens + odds
    puts("#{res}")
    puts()
end

=begin
-----------------------------------
SAMPLE OUTPUT
ruby .\FunSort.rb
Input: @list = [1, 2, 3, 4, 5, 6]
[2, 4, 6, 1, 3, 5]

Input: @list = [1, 2]
[2, 1]

Input: @list = [1]
[1]
-----------------------------------
=end



