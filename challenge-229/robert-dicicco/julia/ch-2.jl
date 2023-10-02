#!/usr/bin/env julia
#=
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-09
Challenge 229 Two Out Of Three  Task 2 ( Julia )
------------------------------------------------
=#
using Printf

arrays = [[1, 1, 2, 4,],[2, 4],[4]]
#arrays = [[4, 1],[2, 4],[1, 2]]

hash = Dict()
cnt = 1

function CreateCounts(a)
    for i in a
        if haskey(hash, i)
            hash[i] += 1
        else
            hash[i] = 1
        end
    end
end

for a in arrays
    global cnt
    a = unique(a)
    if cnt == 1
        array1 = a
        CreateCounts(array1)
        @printf("Input:  @array1 = %s\n", array1)
    elseif cnt == 2
        array2 = a
        CreateCounts(array2)
        @printf("\t@array2 = %s\n", array2)
    elseif cnt == 3
        array3 = a
        CreateCounts(array3)
        @printf("\t@array3 = %s\n", array3)
    end
    cnt += 1
end

@printf("Output: [ ")
for (key, value) in hash
    if value >= 2
        @printf("%d ",key)
    end
end
print("]\n\n")

#=
------------------------------------------------
SAMPLE OUTPUT
julia .\TwoThree.jl
Input:  @array1 = [1, 2, 4]
        @array2 = [2, 4]
        @array3 = [4]
Output: [ 4 2 ]

julia .\TwoThree.jl
Input:  @array1 = [4, 1]
        @array2 = [2, 4]
        @array3 = [1, 2]
Output: [ 4 2 1 ]
------------------------------------------------
=#


