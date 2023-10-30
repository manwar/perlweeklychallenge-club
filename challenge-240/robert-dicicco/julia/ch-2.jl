#!/usr/bin/env julia
#=
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 23-OCT-2023
Challenge 240 Task 02 Build Array ( Julia )
-----------------------------------
=#

using Printf

myints = [[0, 2, 1, 5, 3, 4],[5, 0, 1, 2, 3, 4]]

for mints in myints
    out = []
    @printf("Input: @sints = %s\n",mints)
    cnt = 1
    while cnt <= length(mints)
        push!(out,mints[mints[cnt]+1])
        cnt += 1
    end
    @printf("Output: %s\n\n", out)
end

#=
-----------------------------------
SAMPLE OUTPUT

julia .\BuildArray.jl

Input: @sints = [0, 2, 1, 5, 3, 4]
Output: Any[0, 1, 2, 4, 5, 3]

Input: @sints = [5, 0, 1, 2, 3, 4]
Output: Any[4, 5, 0, 1, 2, 3]
-----------------------------------
=#


