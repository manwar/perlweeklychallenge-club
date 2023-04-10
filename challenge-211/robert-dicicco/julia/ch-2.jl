#!/usr/bin/env julia
#=
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-04
Challenge 211 Split Same Average ( Julia )
----------------------------------------
=#
using Printf
using Combinatorics

nums = [1,2,3,4,5,6,7,8]
#nums = [1,3]

flag = 0;
sec_arr = []

for ndx in 1:5
@printf("Set Size = %d\n", ndx)
@printf("Input: @nums = %s\n",nums)
mycheck = false
Set1 = Set(nums)

for s2 in combinations(nums,ndx)
    global flag
    Set2 = Set(s2)
    Set3 = setdiff(Set1, Set2)
    x = reduce(+, Set3)
    y = reduce(+, Set2)
    if x/length(Set3) == y/length(Set2)
        println("\t",Set2,' ',Set3)
        flag = 1
    end
end

if flag == 1
    println("Output: true\n")
else
    println("Output: false\n")
end
global flag = 0
end

#=
----------------------------------------
SAMPLE OUTPUT
julia .\SplitSame.jl
Set Size = 1
Input: @nums = [1, 2, 3, 4, 5, 6, 7, 8]
Output: false

Set Size = 2
Input: @nums = [1, 2, 3, 4, 5, 6, 7, 8]
        Set([8, 1]) Set([5, 4, 6, 7, 2, 3])
        Set([7, 2]) Set([5, 4, 6, 8, 3, 1])
        Set([6, 3]) Set([5, 4, 7, 2, 8, 1])
        Set([5, 4]) Set([6, 7, 2, 8, 3, 1])
Output: true

Set Size = 3
Input: @nums = [1, 2, 3, 4, 5, 6, 7, 8]
Output: false

Set Size = 4
Input: @nums = [1, 2, 3, 4, 5, 6, 7, 8]
        Set([7, 2, 8, 1]) Set([5, 4, 6, 3])
        Set([6, 8, 3, 1]) Set([5, 4, 7, 2])
        Set([5, 4, 8, 1]) Set([6, 7, 2, 3])
        Set([4, 6, 7, 1]) Set([5, 2, 8, 3])
        Set([5, 2, 8, 3]) Set([4, 6, 7, 1])
        Set([6, 7, 2, 3]) Set([5, 4, 8, 1])
        Set([5, 4, 7, 2]) Set([6, 8, 3, 1])
        Set([5, 4, 6, 3]) Set([7, 2, 8, 1])
Output: true

Set Size = 5
Input: @nums = [1, 2, 3, 4, 5, 6, 7, 8]
Output: false
----------------------------------------
=#


