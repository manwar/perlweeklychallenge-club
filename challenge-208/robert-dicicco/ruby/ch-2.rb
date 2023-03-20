#!/usr/bin/env ruby
=begin
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-15
Challenge 208 'Duplicate and Missing' ( Ruby )
----------------------------------------------
=end

nums = [[1,2,2,4],[1,2,3,4],[1,2,3,3]];

nums.each do |a|
    found = 0
    puts("Input: @nums = #{a}")
    ln = a.length()
    (0..ln-1).each do |n|
        if a[n] != n+1
            puts("Output: (#{a[n]},#{n+1})")
            found = 1
        end
    end
    if found == 0
        puts("Output: -1")
    end
    puts(" ")
end

=begin
----------------------------------------------
SAMPLE OUTPUT
ruby .\DupMissing.rb
Input: @nums = [1, 2, 2, 4]
Output: (2,3)

Input: @nums = [1, 2, 3, 4]
Output: -1

Input: @nums = [1, 2, 3, 3]
Output: (3,4)
----------------------------------------------
=end




