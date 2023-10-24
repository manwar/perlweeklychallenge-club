#!/usr/bin/env ruby
=begin
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 23-OCT-2023
Challenge 240 Task 02 Build Array ( Ruby )
-----------------------------------
=end

myints = [[0, 2, 1, 5, 3, 4],[5, 0, 1, 2, 3, 4]]

myints.each do |mints|
    out = []
    puts("Input: @ints = #{mints}")
    cnt = 0
    while cnt < mints.length()
        out.push(mints[mints[cnt]])
        cnt += 1
    end
    puts("Output: #{out}\n\n");
end

=begin
-----------------------------------
SAMPLE OUTPUT

ruby .\BuildArray.rb

Input: @ints = [0, 2, 1, 5, 3, 4]
Output: [0, 1, 2, 4, 5, 3]

Input: @ints = [5, 0, 1, 2, 3, 4]
Output: [4, 5, 0, 1, 2, 3]
-----------------------------------
=end


