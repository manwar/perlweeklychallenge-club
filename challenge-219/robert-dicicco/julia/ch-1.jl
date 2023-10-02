#!/usr/bin/env julia
using Printf
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-29
Challenge 219 Sorted Squares Task 1 ( Julia )
--------------------------------------
=#

list = [[-2, -1, 0, 3, 4],
       [5, -4, -1, 3, 6]
      ];

for lst in list
    @printf("Input: @list = %s\n",lst)
    lst = map((x) -> x ^ 2, lst)
    @printf("%s\n\n",sort(lst))
end

#=
--------------------------------------
SAMPLE OUTPUT
julia .\SortedSquares.jl

Input: @list = [-2, -1, 0, 3, 4]
[0, 1, 4, 9, 16]

Input: @list = [5, -4, -1, 3, 6]
[1, 9, 16, 25, 36]

--------------------------------------
=#


