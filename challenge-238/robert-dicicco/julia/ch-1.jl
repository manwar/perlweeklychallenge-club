#!/usr/bin/env julia
#=
---------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-09
Challenge 238 Task 01 Running Sum ( Julia )
---------------------------------
=#
using Printf

myints = [[1, 2, 3, 4, 5],[1, 1, 1, 1, 1],[0, -1, 1, 2]]

for mints in myints
    @printf("Input: @int = %s\n",mints)
    sum = 0
    out = []
    out = accumulate(+, mints)
    @printf("Output: %s\n\n",out)
end
#=
---------------------------------
SAMPLE OUTPUT
julia .\RunningSum.jl

Input: @int = [1, 2, 3, 4, 5]
[1, 3, 6, 10, 15]

Input: @int = [1, 1, 1, 1, 1]
[1, 2, 3, 4, 5]

Input: @int = [0, -1, 1, 2]
[0, -1, 0, 2]
---------------------------------
=#



