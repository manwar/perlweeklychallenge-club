#!usr/bin/env julia
#=
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-05
Challenge 237 Task 02 Maximise Greatness ( Julia )
-----------------------------------------
=#
using Printf
using Combinatorics

mynums = [[1, 3, 5, 2, 1, 3, 1], [1, 2, 3, 4]]

maxscore = 0;
score = 0;

function CalcScore(a,b)
    cnt = 1
    score = 0
    while cnt < length(a)
        if a[cnt] < b[cnt]
            score += 1
        end
        cnt += 1
    end
    return score
end

for nums in mynums
    global maxscore,score
    @printf("Input: @nums = %s\n",nums)
    maxscore = 0
    p = collect(permutations(nums,length(nums)))
    for perm in p
        score = 0
        score = CalcScore(nums, perm)
        ignore = floor(length(nums) / 2 + 1)
        if score >= maxscore && score >= ignore
            maxscore = score
        end
    end
    @printf("Output: %s\n\n",maxscore)
end

#=
-----------------------------------------
SAMPLE OUTPUT
julia .\MaximiseGreatness.jl

Input: @nums = [1, 3, 5, 2, 1, 3, 1]
Output: 4

Input: @nums = [1, 2, 3, 4]
Output: 3
-----------------------------------------
=#




