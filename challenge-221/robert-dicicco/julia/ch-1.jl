#!/usr/bin/env julia
#=
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-13
Challenge 221 Task 1 Good Strings ( Julia )
-------------------------------------
=#

using Printf

total_score = 0

words = [["cat", "bt", "hat", "tree"], ["hello", "world", "challenge"]]
chlist = ["atach","welldonehopper"]
cnt = 1
listcnt = 1

for wds in words
    @printf("Input: @words = %s\n",wds)
    chars = chlist[cnt]
    global total_score = 0
    score = 0
    for w in wds
        ln = length(w)
        for mycnt in 1:ln
            tst = w[mycnt]
            if occursin(tst, chlist[listcnt])
                score += 1
            else
                break
            end
        end
        if score == ln
            @printf("%s\n",w)
            total_score += score
            score = 0
        end
    end
    @printf("\tTotal: %d\n", total_score)
    println()
    global listcnt += 1
end

#=
-------------------------------------
SAMPLE OUTPUT
julia .\GoodStrings.jl

Input: @words = ["cat", "bt", "hat", "tree"]
cat
hat
        Total: 6

Input: @words = ["hello", "world", "challenge"]
hello
world
        Total: 10
-------------------------------------
=#



