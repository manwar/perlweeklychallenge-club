#!/usr/bin/env ruby
=begin
-----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-19
Challenge 222 Task 1 Matching Members ( Ruby )
-----------------------------------------------
=end

allints = [[1, 1, 4, 2, 1, 3],[5, 1, 2, 3, 4],[1, 2, 3, 4, 5]];


for ints in allints
    puts("Input: @ints = #{ints}")
    flag = 0
    sorted = ints.sort
    cnt = 0
    while cnt < ints.length
        if ints[cnt] == sorted[cnt]
            flag += 1
        end
        cnt += 1
    end
    puts("Output: #{flag}\n\n")
end

=begin
-----------------------------------------------
SAMPLE OUTPUT
ruby .\MatchingMembers.rb

Input: @ints = [1, 1, 4, 2, 1, 3]
Output: 3

Input: @ints = [5, 1, 2, 3, 4]
Output: 0

Input: @ints = [1, 2, 3, 4, 5]
Output: 5
-----------------------------------------------
=end


