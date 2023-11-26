#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-11
Challenge 238 Task 02 Persistence Sort ( Ruby )
----------------------------------------
=end

myints = [[15, 99, 1, 34],[50, 25, 33, 22]]

def Reduce ( num )
    steps = 0
    while num > 9
        arr = num.to_s.chars.map(&:to_i)
        num = arr.reject(&:zero?).inject(:*)
         steps += 1
    end
    return steps
end

myints.each do |mints|
    h = Hash.new()
    puts("Input: @int = #{mints}")
    for cnt in 0..mints.length() - 1
        retval = Reduce(mints[cnt])
        h[mints[cnt]] = retval
        cnt += 1
    end
    h2 = h.sort_by {|_key, value| value}.to_h
    puts("Output: #{h2.keys}\n\n")
end

=begin
----------------------------------------
SAMPLE OUTPUT

ruby .\Persistence.rb

Input: @int = [15, 99, 1, 34]
Output: [1, 15, 34, 99]

Input: @int = [50, 25, 33, 22]
Output: [22, 33, 50, 25]
----------------------------------------
=end


