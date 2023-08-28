#!/usr/bin/env julia
#=
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Min Max Task 1 ( Julia )
----------------------------------------
=#

using Printf

myints = [[3, 2, 1, 4],[3, 1],[2, 1, 3]]
#arr = []

for ints in myints
    arr = []
    @printf("Input: @ints = %s\n",ints)
    @printf("Output: ")
    if length(ints) <= 2
        @printf("-1\n\n")
        continue
    end
    min = minimum(ints)
    max = maximum(ints)
    for i in ints
        if i > min && i < max
            push!(arr, i)
        end
    end
    @printf("%s\n\n",arr)
end

#=
----------------------------------------
SAMPLE OUTPUT
julia .\MinMax.jl

Input: @ints = [3, 2, 1, 4]
Output: Any[3, 2]

Input: @ints = [3, 1]
Output: -1

Input: @ints = [2, 1, 3]
Output: Any[2]
----------------------------------------
=#


