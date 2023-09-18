#!/usr/bin/env julia
#=
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-14
Challenge 234 Task 2 Unequal Triplets ( Julia )
-----------------------------------
=#

using Printf
using Combinatorics

myints = [[4, 4, 2, 4, 3],[1, 1, 1, 1, 1],[4, 7, 1, 10, 7, 4, 1, 1]]

for mints in myints
    cnt = 0
    @printf("Input: @ints = %s\n",mints)
    for res in combinations(mints, 3)
        if ((res[1] != res[2]) && (res[2] != res[3]) && (res[1] != res[3]))
            cnt += 1
        end
    end
    @printf("Output: %s\n\n",cnt)
end

#=
-----------------------------------
SAMPLE OUTPUT
julia .\UnequalTriplets.jl

Input: @ints = [4, 4, 2, 4, 3]
Output: 3

Input: @ints = [1, 1, 1, 1, 1]
Output: 0

Input: @ints = [4, 7, 1, 10, 7, 4, 1, 1]
Output: 28
-----------------------------------
=#


