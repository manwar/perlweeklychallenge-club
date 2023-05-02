#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-01
Challenge 215 Odd One Out ( Ruby )
----------------------------------------
=end

words = [["abc","xyz","tsu"],["rat", "cab", "dad"],["x", "y", "z"]]

words.each do |wds|
    cnt = 0
    puts("Input: @words = #{wds}")
    wds.each do |w|
        srt = w.chars.sort.join
        if w != srt
            cnt += 1
        end
    end
    puts("Output: #{cnt}")
    puts
end

=begin
----------------------------------------
SAMPLE OUTPUT
ruby .\OddOneOut.rb
Input: @words = ["abc", "xyz", "tsu"]
Output: 1

Input: @words = ["rat", "cab", "dad"]
Output: 3

Input: @words = ["x", "y", "z"]
Output: 0
----------------------------------------
=end


