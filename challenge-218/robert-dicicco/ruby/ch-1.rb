#!/usr/bin/env ruby
=begin
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-22
Challenge 218 Maximum Product ( Ruby )
-----------------------------------------
=end

lists = [[3, 1, 2],[4, 1, 3, 2],[-1, 0, 1, 3, 1],[-8, 2, -9, 0, -4, 3]]

maxval = 0
maxthree = []

lists.each do |lst|
puts("Input: @list = #{lst}")
    ax = lst.combination(3).to_a.sort
    ax.each do |c|
        prod = c[0] * c[1] * c[2]
        if prod > maxval
            maxval = prod
            maxthree = c.sort
        end
    end
    puts("Output: #{maxval}")
    puts("#{maxthree[0]} x #{maxthree[1]} x #{maxthree[2]} = #{maxval}")
    maxval = 0
    maxthree = []
    puts("")
end

=begin
-----------------------------------------
SAMPLE OUTPUT
ruby .\MaxProduct.rb

Input: @list = [3, 1, 2]
Output: 6
1 x 2 x 3 = 6

Input: @list = [4, 1, 3, 2]
Output: 24
2 x 3 x 4 = 24

Input: @list = [-1, 0, 1, 3, 1]
Output: 3
1 x 1 x 3 = 3

Input: @list = [-8, 2, -9, 0, -4, 3]
Output: 216
-9 x -8 x 3 = 216
-----------------------------------------
=end



