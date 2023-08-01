#/usr/bin/env julia
#=
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-31
Challenge 228 Task 1 Unique Sum ( Julia )
-----------------------------------------
=#

using Printf

myints = [[2, 1, 3, 2],[1, 1, 1, 1],[2, 1, 3, 4]]

hash = Dict()

function CreateHash(h)
    ln = length(h)
    cnt = 1
    while cnt <= ln
        hkey = h[cnt]
        hash[hkey] = 0
        cnt += 1
    end
    cnt = 1
    while cnt <= ln
        hkey = h[cnt]
        hash[hkey] += 1
        cnt += 1
    end
end

function FindUniqueSum()
    global hash
    flag = 0
    sum = 0
    for (key, value) in hash
        if hash[key] == 1
            sum += key
        end
    end
    @printf("Output: %d\n\n",sum)
end

for h in myints
    global hash
    @printf("Input: @int = %s\n", h)
    CreateHash(h)
    FindUniqueSum()
    hash = Dict()
end

#=
-----------------------------------------
SAMPLE OUTPUT
julia .\UniqueSum.jl

Input: @int = [2, 1, 3, 2]
Output: 4

Input: @int = [1, 1, 1, 1]
Output: 0

Input: @int = [2, 1, 3, 4]
Output: 10
-----------------------------------------
=#


