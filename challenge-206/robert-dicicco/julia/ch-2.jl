#!/usr/bin/env julia
#=
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-01
Challenge 206 Array Pairings ( Julia )
lia----------------------------------------
=#

using Printf

arrs = [[1,2,3,4],[0,2,1,3]]
pairs = [[0,1,2,3], [0,2,1,3], [0,3,1,2]]
maxval = 0

for arr in arrs
    global maxval
    @printf("Input: @array = %s\n",arr)
    for pr in pairs
        a1 = pr[1:2]
        sum1 = arr[minimum(a1)+1]
        a2 = pr[3:4]
        sum2 = arr[minimum(a2)+1]
        sum = sum1 + sum2
        if sum > maxval
            maxval = sum
        end
    end
    @printf("Output: %d\n\n",maxval)
    maxval = 0
end

#=
----------------------------------------
SAMPLE OUTPUT
julia .\ArrayPairings.jl
Input: @array = [1, 2, 3, 4]
Output: 4

Input: @array = [0, 2, 1, 3]
Output: 2
----------------------------------------
=#
