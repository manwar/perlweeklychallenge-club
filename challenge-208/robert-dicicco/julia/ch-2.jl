#!/usr/bin/env julia
#=
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-15
Challenge 208 'Duplicate and Missing' ( Julia )
----------------------------------------------
=#
using Printf

nums = [[1,2,2,4],[1,2,3,4],[1,2,3,3]];\

for a in nums
    found = 0
    @printf("Input: @nums = %s\n",a)
    ln = length(a)
    for n in 1:ln
        if (a[n] != n)
            @printf("Output: (%d,%d)\n",a[n],n)
            found = 1
        end
    end
    if found == 0
        @printf("Output: -1\n")
    end
    println(" ")
end
#=
----------------------------------------------
SAMPLE OUTPUT
julia .\DupMissing.jl
Input: @nums = [1, 2, 2, 4]
Output: (2,3)

Input: @nums = [1, 2, 3, 4]
Output: -1

Input: @nums = [1, 2, 3, 3]
Output: (3,4)
----------------------------------------------
=#

