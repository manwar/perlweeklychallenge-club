#!/usr/bin/env julia
#=
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-01
Challenge 228 Task 2 Empty Array ( Julia )
---------------------------------------
=#

using Printf

myints = [[3, 4, 2],[1,2,3]]

for i in myints
    @printf("Input: @int = %s\n",i)
    cnt = 0
    while length(i) > 0
        min = minimum(i)
        #@printf("min = %d\n",min)
        #@printf("before %s\n",i)
        if (i[1] == min)
            popfirst!(i)
        else
            push!(i,i[1])
            popfirst!(i)
        end
        #@printf("after %s\n",i)
        length(i) > 0 ? @printf("%s\n",i) : @printf("%s\n","()")
        cnt += 1
    end
    @printf("Output: %d\n\n",cnt)
end

#=
---------------------------------------
SAMPLE OUTPUT
julia .\EmptyArray.jl

Input: @int = [3, 4, 2]
[4, 2, 3]
[2, 3, 4]
[3, 4]
[4]
()
Output: 5

Input: @int = [1, 2, 3]
[2, 3]
[3]
()
Output: 3
---------------------------------------
=#



