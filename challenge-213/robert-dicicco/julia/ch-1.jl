#!/usr/bin/env julia
#=
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-17
Challenge 213 Fun Sort ( Julia )
-----------------------------------
=#
using Printf

mylists = [[1,2,3,4,5,6],[1,2],[1]]

for arr in mylists
    @printf("Input: @list = %s\n", arr)
    evens = arr[findall(iseven, arr)]
    odds  = arr[findall(isodd, arr)]
    combo = cat(evens, odds, dims =(1, 1))
    @printf("%s\n",combo)
end

#=
-----------------------------------
SAMPLE OUTPUT
julia .\FunSort.jl
Input: @list = [1, 2, 3, 4, 5, 6]
[2, 4, 6, 1, 3, 5]
Input: @list = [1, 2]
[2, 1]
Input: @list = [1]
[1]
-----------------------------------
=#


