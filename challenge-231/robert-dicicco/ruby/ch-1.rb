#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Min Max Task 1 ( Ruby )
----------------------------------------
=end

myints = [[3, 2, 1, 4],[3, 1],[2, 1, 3]]

myints.each do |ints|
    puts("Input: @ints = #{ints}")
    print "Output: "
    if ints.length() <= 2
        puts("-1\n\n")
        next
    end
    min = ints.min
    max = ints.max
    print "[ "
    ints.each do |i|
        if i > min and i < max
            print("#{i} ")
        end
    end
    puts("]\n\n")
end

=begin
----------------------------------------
SAMPLE OUTPUT
ruby .\MinMax.rb

Input: @ints = [3, 2, 1, 4]
Output: [ 3 2 ]

Input: @ints = [3, 1]
Output: -1

Input: @ints = [2, 1, 3]
Output: [ 2 ]
----------------------------------------
=end
