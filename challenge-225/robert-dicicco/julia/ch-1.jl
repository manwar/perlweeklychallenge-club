#!/usr/bin/env julia
#=
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-10
Challenge 225 Task 1 Max Words ( Julia )
-----------------------------------
=#

using Printf

lists = [["Perl and Raku belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference."],
                ["The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members."]]

max_num = 0

for lst in lists
    global max_num
    @printf("Input: @list = %s\n",lst)
    cnt = 1
    sz = length(lst)
    while cnt < sz
        words = split(lst[cnt])
        ln = length(words)
        if ln > max_num
            max_num = ln
        end
        cnt += 1
    end
    @printf("Output: %d\n\n", max_num)
    max_num = 0
end

#=
-----------------------------------
SAMPLE OUTPUT
julia .\MaxWords.jl
Input: @list = ["Perl and Raku belong to the same family.", "I love Perl.", "The Perl and Raku Conference."]
Output: 8

Input: @list = ["The Weekly Challenge.", "Python is the most popular guest language.", "Team PWC has over 300 members."]
Output: 7
-----------------------------------
=#



