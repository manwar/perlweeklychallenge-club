#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-01
Challenge 228 Task 2 Empty Array ( Raku )
---------------------------------------
=end

myints = [[3, 4, 2],[1,2,3]]

myints.each do |i|
    puts("Input: @int = #{i}")
    cnt = 0
    while i.length() > 0
        min = i.min()
        if (i[0] == min)
            i.shift()
        else
            i.push(i[0])
            i.shift()
        end
        i.length() > 0 ? puts("#{i}") : puts("()")
        cnt += 1
    end
    puts("Output: #{cnt}\n\n")
end

=begin
---------------------------------------
SAMPLE OUTPUT
ruby .\EmptyArray.rb

Input: @int = [3, 4, 2]
[4, 2, 3]
[2, 3, 4]
[3, 4]
[4]
()
Output: 5

Input: @int = [1, 2, 3]
[2, 3]
[3]
()
Output: 3
---------------------------------------
=end


