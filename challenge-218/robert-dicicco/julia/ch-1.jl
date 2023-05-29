#!/usr/bin/env julia
#=
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-22
Challenge 218 Maximum Product ( Julia )
-----------------------------------------
=#
using Printf
using Combinatorics

lists = [[3, 1, 2],[4, 1, 3, 2],[-1, 0, 1, 3, 1],[-8, 2, -9, 0, -4, 3]]

maxthree = []

for lst in lists
    global maxthree
    maxval = 0
    @printf("Input: @list = %s\n", lst)
    for c in combinations(lst,3)
        prod = c[1] * c[2] * c[3]
        if prod > maxval
            maxval = prod
            maxthree = sort(c)
        end
    end
    @printf("Output: %d\n",maxval)
    @printf("%d x %d x %d = %d\n", maxthree[1],maxthree[2],maxthree[3],maxval)
    println("----------------------")
end

#=
-----------------------------------------
SAMPLE OUTPUT
julia .\MaxProduct.jl

Input: @list = [3, 1, 2]
Output: 6
1 x 2 x 3 = 6
----------------------
Input: @list = [4, 1, 3, 2]
Output: 24
2 x 3 x 4 = 24
----------------------
Input: @list = [-1, 0, 1, 3, 1]
Output: 3
1 x 1 x 3 = 3
----------------------
Input: @list = [-8, 2, -9, 0, -4, 3]
Output: 216
-9 x -8 x 3 = 216
-----------------------------------------
=#


