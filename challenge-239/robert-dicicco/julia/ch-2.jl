#!/usr/bin/env julia
#=
---------------------------------------
AUTHOR : Robert DiCicco
DATE   : 2023-10-21
Challenge 239 Task 02 Consistent Strings ( Julia )
--------------------------------------
=#

using Printf

mystr = [["ad", "bd", "aaab", "baa", "badab", "ab"],
              ["a", "b", "c", "ab", "ac", "bc", "abc","abc"],
              ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d","cad"]]
cnt = 1

function CheckConsistent(str, mallowed)
    total = 0
    #m_arr = split(mallowed,"")
    Set1 = Set(split(mallowed,""))
    i = 1
    while i <= length(str) - 1
        s_arr = split(str[i],"")
        Set2 = Set(s_arr)
        i += 1
        setresult = setdiff(Set2, Set1)
        if isempty(setresult)
            total += 1
        end
    end
    return total
end

while cnt <= length(mystr)
    global cnt
    ln = length(mystr[cnt]) - 1
    @printf("Input: @str = %s\n", mystr[cnt][1:ln])
    mallow = mystr[cnt][end]
    @printf("allowed = %s\n",mallow)
    retval = CheckConsistent(mystr[cnt], mallow)
    @printf("Output: %s\n\n",retval)
    cnt += 1
end

#=
---------------------------------------
SAMPLE OUTPUT

julia .\Consistent.jl

Input: @str = ["ad", "bd", "aaab", "baa", "badab"]
allowed = ab
Output: 2

Input: @str = ["a", "b", "c", "ab", "ac", "bc", "abc"]
allowed = abc
Output: 7

Input: @str = ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]
allowed = cad
Output: 4
--------------------------------------
=#


