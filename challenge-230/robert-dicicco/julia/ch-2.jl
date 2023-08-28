#!/usr/bin/env julia
#=
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-15
Challenge 230 Count Words Task 2 ( Julia )
-------------------------------------------
=#
using Printf
using Match

wds = [["pay", "attention", "practice", "attend"],["janet", "julia", "java", "javascript"]]
prefix = ["at", "ja"]

cnt = 1

for w in wds
    global cnt
    seen = 0
    @printf("Input:  @words = %s\n",w)
    @printf("\t\$prefix = %s\n", prefix[cnt])
    p = Regex("^" * prefix[cnt])
    for elem in w
    if isnothing(match(p, elem))
            continue
        else
            seen += 1
        end
    end
    @printf("\tOutput: %d\n\n", seen)
    cnt += 1
end

#=
-------------------------------------------
SAMPLE OUTPUT
julia .\CountWords.jl
Input:  @words = ["pay", "attention", "practice", "attend"]
        $prefix = at
        Output: 2

Input:  @words = ["janet", "julia", "java", "javascript"]
        $prefix = ja
        Output: 3
-------------------------------------------
=#


