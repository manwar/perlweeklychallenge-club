#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-18
Challenge 235 Task 1 Remove One ( Ruby )
---------------------------------------
=end

myints = [[0, 2, 9, 4, 6],[5, 1, 3, 2],[2, 2, 3]]

myints.each do |mints|
    puts("Input: @ints = #{mints}")
    len = mints.length()
    cnt = 0
    x = 1
    while x < len
        if mints[x] > mints[x-1]
            puts("\t#{mints[x]} greater than #{mints[x-1]}")
            x += 1
        elsif mints[x] == mints[x-1]
            puts("\t#{mints[x]} equal to #{mints[x-1]}")
            x += 1
            cnt += 1
        else
            puts("\t#{mints[x]} less than #{mints[x-1]}")
            x += 1
            cnt += 1
        end
    end
    cnt == 1 ? puts("Output: true\n\n") : puts("Output: false\n\n")
end

=begin
---------------------------------------
SAMPLE OUTPUT
ruby .\RemoveOne.rb
Input: @ints = [0, 2, 9, 4, 6]
        2 greater than 0
        9 greater than 2
        4 less than 9
        6 greater than 4
Output: true

Input: @ints = [5, 1, 3, 2]
        1 less than 5
        3 greater than 1
        2 less than 3
Output: false

Input: @ints = [2, 2, 3]
        2 equal to 2
        3 greater than 2
Output: true
---------------------------------------
=end


