#!/usr/bin/env ruby
=begin
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Separate Digits  Task 1 ( Ruby )
-----------------------------------
=end

myints = [[1, 34, 5, 6], [1, 24, 51, 60]]

myints.each do |ints|
    str = ""
    puts("Input: @ints = #{ints}")
    ints.each do |digit|
        str += digit.to_s
    end
    arr = str.each_char.map { |c| Integer(c) }
    puts("Output: #{arr}\n\n")
end

=begin
-----------------------------------
SAMPLE OUTPUT
ruby .\SeperateDigits.rb

Input: @ints = [1, 34, 5, 6]
Output: [1, 3, 4, 5, 6]

Input: @ints = [1, 24, 51, 60]
Output: [1, 2, 4, 5, 1, 6, 0]
-----------------------------------
=end


