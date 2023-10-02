#!/usr/bin/env julia
#=
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-08
Challenge 220 Task 2 Squareful ( Julia )
------------------------------------------
=#
using Printf
using Combinatorics

myints = [[1,8,17],[1,8,17,19]]

p=[]

function IsPerfectSquare(number_to_test)
    root = floor(sqrt(number_to_test))
    if ((root ^ 2 ) == number_to_test)
        return true;
    end
    return false;
end

for intsub in myints
    @printf("Input: @ints = %s\n",intsub)
    ln = length(intsub)
    @printf("Output: ")
    global p = collect(permutations(intsub))
    ln = length(intsub)
    for perm in p
        tv = 1
        flag = 0
        while tv < ln
              if IsPerfectSquare(perm[tv] + perm[tv + 1])
               flag += 1
            else
                flag = 0
            end
            tv += 1
        end
        if flag == ln - 1
            @printf("%s ",perm)
        end
    end
    println("\n")
end

#=
------------------------------------------
SAMPLE OUTPUT
julia .\Squareful.jl

Input: @ints = [1, 8, 17]
Output: [1, 8, 17] [17, 8, 1]

Input: @ints = [1, 8, 17, 19]
Output: [1, 8, 17, 19] [19, 17, 8, 1]
------------------------------------------
=#
