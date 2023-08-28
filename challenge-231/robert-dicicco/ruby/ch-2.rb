#!/usr/bin/env ruby
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Senior Citizen Task 2 ( Ruby )
----------------------------------------
=end

lists = [["7868190130M7522","5303914400F9211","9273338290F4010"],["1313579440F2036","2921522980M5644"]]
cnt = 0

lists.each do |lst|
    puts("Input: @list = #{lst}")
    cnt = 0
    lst.each do |info|
        age = info[11,2]
        if age.to_i >= 60
            cnt += 1
        end
    end
    puts("Output: #{cnt}\n\n")
end

=begin
----------------------------------------
SAMPLE OUTPUT
ruby .\SeniorCit.rb

Input: @list = ["7868190130M7522", "5303914400F9211", "9273338290F4010"]
Output: 2

Input: @list = ["1313579440F2036", "2921522980M5644"]
Output: 0
----------------------------------------
=end


