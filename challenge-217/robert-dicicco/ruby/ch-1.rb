#!/usr/bin/env ruby
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-15
Challenge 217 Sorted Matrix ( Ruby )
--------------------------------------
=end comment
arg = ARGV[0].to_i
if ARGV.length == 0
    puts("Error! arg must be between 0 and 2 inclusive")
    exit
end


if arg < 0 or arg > 2
    puts("Error! arg must be between 0 and 2 inclusive")
    exit
end
case arg
when 0
    matrix = [[3,1,2],[5,2,4],[0,1,3]]
when 1
    matrix = [[2,1], [4,5]]
when 2
    matrix = [[1,0,3],[0,0,0],[ 1,2,1]];
end
out = []
puts("Input @matrix = #{matrix}")
matrix.each do |arr|
    arr.each do |val|
        out.push(val)
    end
end
puts("Output: #{out.sort![2]}")
puts(" ")

=begin comment
--------------------------------------
SAMPLE OUTPUT
ruby .\SortedMatrix.rb 0
Input @matrix = [[3, 1, 2], [5, 2, 4], [0, 1, 3]]
Output: 1

PS G:\Projects\Perl\Challenges> ruby .\SortedMatrix.rb 1
Input @matrix = [[2, 1], [4, 5]]
Output: 4

PS G:\Projects\Perl\Challenges> ruby .\SortedMatrix.rb 2
Input @matrix = [[1, 0, 3], [0, 0, 0], [1, 2, 1]]
Output: 0
--------------------------------------
=end comment


