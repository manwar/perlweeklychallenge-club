#!/usr/bin/env julia
#=
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-18
Challenge 235 Task 1 Remove One ( Julia )
---------------------------------------
=#

using Printf

myints = [[0, 2, 9, 4, 6],[5, 1, 3, 2],[2, 2, 3]]

for mints in myints
    @printf("Input: @ints = %s\n",mints)
    len = length(mints)
    cnt = 0
    x = 2
    while x <= len
        if mints[x] > mints[x-1]
            @printf("\t%d greater than %d\n", mints[x], mints[x-1])
            x += 1
        elseif mints[x] == mints[x-1]
            @printf("\t%d equal to %d\n", mints[x], mints[x-1])
            x += 1
            cnt += 1
        else
            @printf("\t%d less than %d\n", mints[x], mints[x-1])
            x += 1
            cnt += 1
        end
    end
    cnt == 1 ? println("Output: true\n") : println("Output: false\n")
end

#=
---------------------------------------
SAMPLE OUTPUT
julia .\RemoveOne.jl

Input: @ints = [0, 2, 9, 4, 6]
        2 greater than 0
        9 greater than 2
        4 less than 9
        6 greater than 4
Output: true

Input: @ints = [5, 1, 3, 2]
        1 less than 5
        3 greater than 1
        2 less than 3
Output: false

Input: @ints = [2, 2, 3]
        2 equal to 2
        3 greater than 2
Output: true
---------------------------------------
=#


