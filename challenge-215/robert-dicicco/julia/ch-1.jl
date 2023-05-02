#!/usr/bin/env julia
#=
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-01
Challenge 215 Odd One Out ( Julia )
----------------------------------------
=#
using Printf

words = [["abc","xyz","tsu"],["rat", "cab", "dad"],["x", "y", "z"]]

for wds in words
    cnt = 0
    @printf("Input: @words = %s\n",wds)
    for w in wds
        str1_arr = join(sort(collect(w)))
        if (cmp(w,str1_arr) != 0)
            cnt += 1
        end
    end
    @printf("Output: %d\n\n", cnt)
end

#=
----------------------------------------
SAMPLE OUTPUT
julia .\OddOneOut.jl
Input: @words = ["abc", "xyz", "tsu"]
Output: 1

Input: @words = ["rat", "cab", "dad"]
Output: 3

Input: @words = ["x", "y", "z"]
Output: 0
----------------------------------------
=#


