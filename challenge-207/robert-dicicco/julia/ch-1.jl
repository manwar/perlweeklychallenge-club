#!/usr/bin/env julia
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-06
Challenge 207 Keyboard Word ( Julia )
--------------------------------------
=#
using Printf

rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
words = ["Hello", "Alaska", "Dad", "Peace"], ["OMG", "Bye"]
flag = 0

function CheckLetters(w)
    ln = length(w)
    for j in 1:3
        flag = 0
        for x in 1:ln
            if (occursin(w[x], rows[j]))
            else
                flag = 1
            end
         end
        if (flag == 0)
            @printf("\t%s\n",w)
            flag = 0
        end
    end
end

for wds in words
    @printf("Input: @words = %s\n",wds)
    println("Output:")
    ln = length(wds)
    for j in 1:ln
        CheckLetters(lowercase(wds[j]))
    end
    println(" ")
end

#=
--------------------------------------
SAMPLE OUTPUT
julia .\KeyboardWord.jl
Input: @words = ["Hello", "Alaska", "Dad", "Peace"]
Output:
        alaska
        dad

Input: @words = ["OMG", "Bye"]
Output:

--------------------------------------
=#
