#!/usr/bin/env ruby
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  ; 2023-09-18
Challenge 235 Task 02 Duplicate Zaroes ( Ruby )
------------------------------------------
=end comment

myints = [[1, 0, 2, 3, 0, 4, 5, 0],[1, 2, 3],[0, 3, 0, 4, 5]]

myints.each do |mints|
    puts("Input: @ints = #{mints}")
    seen = Array.new
    len = mints.length()
    mints.each do |x|
        if x == 0
            seen.push(0,0)
        else
            seen.push(x)
         end
    end
    puts("Output: #{seen.slice(0,len)}\n\n")
end

=begin comment
------------------------------------------
SAMPLE OUTPUT
ruby .\DuplicateZeros.rb

Input: @ints = [1, 0, 2, 3, 0, 4, 5, 0]
Output: [1, 0, 0, 2, 3, 0, 0, 4]

Input: @ints = [1, 2, 3]
Output: [1, 2, 3]

Input: @ints = [0, 3, 0, 4, 5]
Output: [0, 0, 3, 0, 0]
------------------------------------------
=end comment




