#!/usr/bin/env ruby
=begin
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-29
Challenge 219 Sorted Squares Task 1 ( Ruby )
--------------------------------------
=end

list = [[-2, -1, 0, 3, 4],
        [5, -4, -1, 3, 6]
       ];

list.each do |lst|
    puts("Input: @list = #{lst}")
    lst = lst.map { |val| val ** 2 }
    puts("#{lst.sort}\n\n")
end

=begin
--------------------------------------
SAMPLE OUTPUT
ruby .\SortedSquares.rb

Input: @list = [-2, -1, 0, 3, 4]
[0, 1, 4, 9, 16]

Input: @list = [5, -4, -1, 3, 6]
[1, 9, 16, 25, 36]

--------------------------------------
=end


