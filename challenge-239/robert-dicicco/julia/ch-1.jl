#!/usr/bin/env julia
#=
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-16
Challenge 239 Task 01 Same String ( Julia )
------------------------------------
=#
using Printf

myarr1 = [["ab", "c"],["ab", "c"],["ab", "cd", "e"]]
myarr2 = [["a", "bc"],["ac", "b"],["abcde"]]

cnt = 1
while cnt <= length(myarr1)
    global cnt
    @printf("Input:  @arr1 = %s\n",myarr1[cnt])
    @printf("\t@arr2 = %s\n", myarr2[cnt])
    join(myarr1[cnt],"") == join(myarr2[cnt],"") ? println("Output: true\n") : println("Output: false\n")
    cnt += 1
end

#=
-------------------------------------
SAMPLE OUTPUT

julia .\SameString.jl

Input:  @arr1 = ["ab", "c"]
        @arr2 = ["a", "bc"]
Output: true

Input:  @arr1 = ["ab", "c"]
        @arr2 = ["ac", "b"]
Output: false

Input:  @arr1 = ["ab", "cd", "e"]
        @arr2 = ["abcde"]
Output: true
------------------------------------
=#


