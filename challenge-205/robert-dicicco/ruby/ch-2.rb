#!/usr/bin/env ruby
=begin
-------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02-20
Challenge 205 Maximum XOR ( Ruby )
-------------------------------
=end

maxv = 0

arr = [[1,2,3,4,5,6,7], [2,4,1,3], [10,5,7,12,8]]

arr.each do |a|
    puts("Input: @array = #{a}")
    ax = a.combination(2).to_a
    ax.each do |res|
        xor_v = res[0].to_i ^ res[1].to_i
        if xor_v > maxv
            maxv = xor_v
        end
    end
    puts("Output: #{maxv}")
    maxv = 0
    puts(" ")
end

=begin
-------------------------------
SAMPLE OUTPUT
ruby .\MaximumXOR.rb
Input: @array = [1, 2, 3, 4, 5, 6, 7]
Output: 7

Input: @array = [2, 4, 1, 3]
Output: 7

Input: @array = [10, 5, 7, 12, 8]
Output: 15
-------------------------------
=end
