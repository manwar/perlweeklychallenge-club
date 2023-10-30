#!/usr/bin/env julia
#=
------------------------------------------
AUTHOR: Robert DiCicco
DATE  ; 2023-09-18
Challenge 235 Task 02 Duplicate Zaroes ( Julia )
------------------------------------------
=#
using Printf

myints = [[1, 0, 2, 3, 0, 4, 5, 0],[1, 2, 3],[0, 3, 0, 4, 5]]

for mints in myints
    @printf("Input: @ints = %s\n", mints)
    seen = []
    len = length(mints)
    for x in mints
        if x == 0
            push!(seen, 0,0)
        else
            push!(seen, x)
        end
    end
    @printf("Output: %s\n\n",seen[1:len])
end

#=
------------------------------------------
SAMPLE OUTPUT
julia .\DuplicateZeros.jl

Input: @ints = [1, 0, 2, 3, 0, 4, 5, 0]
Output: Any[1, 0, 0, 2, 3, 0, 0, 4]

Input: @ints = [1, 2, 3]
Output: Any[1, 2, 3]

Input: @ints = [0, 3, 0, 4, 5]
Output: Any[0, 0, 3, 0, 0]
------------------------------------------
=#


