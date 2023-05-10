#!/usr/bin/env julia
#=
--------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-08
Challenge 216 Registration Number ( Julia )
--------------------------------------------
=#
using Printf

words = [["abc", "abcd", "bcd", "AB1 2CD"], ["job", "james", "bjorg", "007 JB"], ["crack", "road", "rac", "C7 RA2"]]

flag = 0
out = []

function CheckWords(wd, rg)
    arr = split(rg,"")
    flag = 0
    for lett in arr
        if ! occursin(lett, wd)
             flag = 1
         end
    end
    if flag == 0
        push!(out, wd)
    end
end

for wds in words
    global out
    len = length(wds)

    reg = wds[end]
    @printf("Input: @words = %s,  \$reg = %s\n", wds[begin:end-1],reg)
    r = r"0|1|2|3|4|5|6|7|8|9| "
    reg = lowercase(replace(reg,r => "" ))
    x = 1
    while x < len
        CheckWords(wds[x], reg)
        x += 1
    end
    println("Output: ["*join(out,",")*"]\n")
    out = []
end

#=
--------------------------------------------
SAMPLE OUTPUT
julia .\Registration.jl
Input: @words = ["abc", "abcd", "bcd"],  $reg = AB1 2CD
Output: [abcd]

Input: @words = ["job", "james", "bjorg"],  $reg = 007 JB
Output: [job,bjorg]

Input: @words = ["crack", "road", "rac"],  $reg = C7 RA2
Output: [crack,rac]
--------------------------------------------
=#


