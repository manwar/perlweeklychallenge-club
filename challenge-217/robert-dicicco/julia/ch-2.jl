#!/usr/bin/env julia
#=
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-16
Challenge 217 Max Number ( Julia )
---------------------------------------
=#
using Printf
using Combinatorics

list = [[5,11,4,1,2],[31, 2, 4,10],[10,3,2],[1, 23],[1,10]];
max = 0


for lst in list
    global max
    @printf("Input: @list = %s\n",lst)
    p = permutations(lst)
    for item in p
        val = join(item)
        n = parse(Int64, val)
        if n > max
            max = n
        end
    end
    @printf("Output: %d\n\n",max)
    max = 0
end

#=
---------------------------------------
SAMPLE OUTPUT
julia .\MaxNumber.jl
Input: @list = [5, 11, 4, 1, 2]
Output: 542111

Input: @list = [31, 2, 4, 10]
Output: 431210

Input: @list = [10, 3, 2]
Output: 3210

Input: @list = [1, 23]
Output: 231

Input: @list = [1, 10]
Output: 110
---------------------------------------
=#


