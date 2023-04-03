#!/usr/bin/env julia
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-28
Challenge 210 Kill&Win ( Julia )
--------------------------------------
=#
using Printf

myint =[[2,3,1],[1,1,2,2,2,3]]
total_score = 0;
max_score = 0;
max_possible = 0;

function Score(arr)
    global total_score,max_possible,max_score
    for testx in arr
        println("trying ",testx)
        for val in arr
            if ((val == testx) || (val == testx-1) || (val == testx+1))
                total_score += val
            end
        end
        if total_score == max_possible
            println("Output: ",total_score)
            println("")
            return
        end
        if total_score > max_score
            max_score = total_score
        end
        total_score = 0
    end
    println("Output: ",max_score)
end

for a in myint
    global max_possible
    println("Input: @int = ",a)
    max_possible = sum(a)
    println("max possible = ",max_possible)
    Score(a)
end

#=
--------------------------------------
SAMPLE OUTPUT
julia .\KillWin.jl
Input: @int = [2, 3, 1]
max possible = 6
trying 2
Output: 6

Input: @int = [1, 1, 2, 2, 2, 3]
max possible = 11
trying 1
trying 1
trying 2
Output: 11
--------------------------------------
=#


