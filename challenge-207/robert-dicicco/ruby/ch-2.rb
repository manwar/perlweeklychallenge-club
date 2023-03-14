#!/usr/bin/env ruby
=begin
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-07
Challenge 207 H-Index ( Ruby)
==================================
=end

citations = [10,8,5,4,3],[25,8,5,3,3]

def CalcIndex(c)
    ln = c.length()
    offset = ln - 1
    pos = ln
    while offset >= 0
        if c[offset] >= pos
            puts("Output: #{pos}")
            puts
            return
        else
            offset -= 1
            pos -= 1
        end
    end
end

citations.each do |c|
    puts("Input: @citations = #{c}")
    CalcIndex(c)
end

=begin
==================================
SAMPLE OUTPUT
ruby .\HIndex.rb
Input: @citations = [10, 8, 5, 4, 3]
Output: 4

Input: @citations = [25, 8, 5, 3, 3]
Output: 3
==================================
=end
