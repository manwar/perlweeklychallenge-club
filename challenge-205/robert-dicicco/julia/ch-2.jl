#!/usr/bin/env julia
#=
-------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02-20
Challenge 205 Maximum XOR ( Julia )
-------------------------------
=#
using Printf
using Combinatorics

maxv = 0

arr = [[1,2,3,4,5,6,7], [2,4,1,3], [10,5,7,12,8]]

for a in arr
    @printf("Input: @array = %s\n",a)
    combo = combinations(a, 2)
    for c in combo
        global maxv
        x = c[1] ⊻ c[2]
        if x > maxv
            maxv = x
        end
    end
    @printf("Output: %d\n\n",maxv)
end

#=
-------------------------------
SAMPLE OUTPUT
julia .\MaximumXOR.jl
Input: @array = [1, 2, 3, 4, 5, 6, 7]
Output: 7

Input: @array = [2, 4, 1, 3]
Output: 7

Input: @array = [10, 5, 7, 12, 8]
Output: 15
-------------------------------
=#


