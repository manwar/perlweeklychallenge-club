#!/usr/bin/env julia
#=
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Separate Digits  Task 1 ( Julia )
-----------------------------------
=#
using Printf

myints = [[1, 34, 5, 6], [1, 24, 51, 60]]

for ints in myints
    str = ""
    @printf("Input: @ints = %s\n",ints)
    for digit in ints
        ch = string(digit, base = 10)
        str *= ch
    end
    arr = split(str,"")
    print("Output: [")
    for i in arr
        @printf("%s ",i)
    end
    println("]\n")
end

#=
-----------------------------------
SAMPLE OUTPUT
julia .\SeperateDigits.jl

Input: @ints = [1, 34, 5, 6]
Output: [1 3 4 5 6 ]

Input: @ints = [1, 24, 51, 60]
Output: [1 2 4 5 1 6 0 ]
-----------------------------------
=#


