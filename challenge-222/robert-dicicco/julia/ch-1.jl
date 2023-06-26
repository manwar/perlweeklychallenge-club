#!/usr/bin/env julia
#=
-----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-19
Challenge 222 Task 1 Matching Members ( Julia )
-----------------------------------------------
=#
using Printf

allints = [[1, 1, 4, 2, 1, 3],[5, 1, 2, 3, 4],[1, 2, 3, 4, 5]]

for ints in allints
    @printf("Input: @ints = %s\n",ints)
    flag = 0
    sorted = sort(ints)
    cnt = 1
    while cnt <= length(ints)
        if ints[cnt] == sorted[cnt]
            flag += 1
        end
        cnt += 1
    end
    @printf("Output: %d\n\n", flag)
end

#=
-----------------------------------------------
SAMPLE OUTPUT
julia .\MatchingMembers.jl

Input: @ints = [1, 1, 4, 2, 1, 3]
Output: 3

Input: @ints = [5, 1, 2, 3, 4]
Output: 0

Input: @ints = [1, 2, 3, 4, 5]
Output: 5
-----------------------------------------------
=#


