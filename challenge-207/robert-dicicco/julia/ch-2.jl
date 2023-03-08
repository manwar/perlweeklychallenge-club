#!/usr/bin/env julia
#=
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-07
Challenge 207 H-Index ( Julia )
----------------------------------
=#
using Printf

citations = [10,8,5,4,3],[25,8,5,3,3]

function CalcIndex(c)
    ln = length(c)
    offset = ln
    pos = ln
    while offset >= 1
        if c[offset] >= pos
            @printf("Output: %d\n", pos)
            println(" ")
            return
        else
            offset -= 1
            pos -= 1
        end
    end
end

for c in citations
    @printf("Input: @citations = %s\n",c)
    CalcIndex(c)
end

#=
----------------------------------
SAMPLE OUTPUT
julia .\HIndex.jl
Input: @citations = [10, 8, 5, 4, 3]
Output: 4

Input: @citations = [25, 8, 5, 3, 3]
Output: 3
----------------------------------
=#
