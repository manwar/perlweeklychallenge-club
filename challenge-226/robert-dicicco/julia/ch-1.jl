#!/usr/bin/env julia
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-19
Challenge 226 Task 1 Shuffle String ( Julia )
--------------------------------------
=#
using Printf

strings = ["lacelengh", "rulepark"]
indices = [[3,2,0,5,4,8,6,7,1],[4,7,3,1,0,5,2,6]]
offset = 1
cnt = 1


for string in strings
    global offset, cnt

    letters = Dict()
    ln = length(string)
    ndx = indices[offset]
    offset += 1
    @printf("Input: \$string = %s, @indices = %s\n",string, ndx)

    while cnt <= ln
        letter = SubString(string, cnt, cnt)
        x = ndx[cnt]
        letters[x] = letter
        cnt += 1
    end

    cnt = 0
    @printf("Output: ");
    while cnt < ln
       @printf("%s",letters[cnt])
        cnt += 1
    end
    println("\n\n")
    #offset = 1
    cnt = 1
end

#=
--------------------------------------
SAMPLE OUTPUT
julia .\ShuffleString.jl

Input: $string = lacelengh, @indices = [3, 2, 0, 5, 4, 8, 6, 7, 1]
Output: challenge

Input: $string = rulepark, @indices = [4, 7, 3, 1, 0, 5, 2, 6]
Output: perlraku
--------------------------------------
=#


