#!/usr/bin/env ruby
=begin
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-10
Challenge 225 Task 1 Max Words ( Ruby )
-----------------------------------
=end

lists = [["Perl and Raku belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference."],
                ["The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members."]]

max_num = 0

lists.each do |lst|
    puts("Input: @list = #{lst}")
    cnt = 0
    while cnt < lst.length
        sz = lst[cnt].split.to_a;
        if sz.length > max_num
            max_num = sz.length
        end
        cnt += 1
    end
    puts("Output: #{max_num}\n\n")
    max_num = 0
end

=begin
-----------------------------------
ruby .\MaxWords.rb
Input: @list = ["Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference."]
Output: 8

Input: @list = ["The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members."]
Output: 7
-----------------------------------
=end


