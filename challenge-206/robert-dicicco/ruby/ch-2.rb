#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-01
Challenge 206 Array Pairings ( Ruby )
----------------------------------------
=end

arrs = [[1,2,3,4],[0,2,1,3]]
pairs = [[0,1,2,3], [0,2,1,3], [0,3,1,2]];
maxval = 0;

arrs.each do |arr|
    puts("Input: @array = #{arr}")
    pairs.each do |pr|
        a1 = pr.slice(0,2)
        sum1 = arr[a1.min()]
        a2 = pr.slice(2,2)
        sum2 = arr[a2.min()]
        sum = sum1 + sum2
        if (sum > maxval )
            maxval = sum
        end
    end
    puts("Output: #{maxval}")
    puts
    maxval = 0
end

=begin
----------------------------------------
SAMPLE OUTPUT
ruby .\ArrayPairings.rb
Input: @array = [1, 2, 3, 4]
Output: 4

Input: @array = [0, 2, 1, 3]
Output: 2
----------------------------------------
=end


