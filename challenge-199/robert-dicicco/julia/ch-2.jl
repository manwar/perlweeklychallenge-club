#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2023-01-13

Challenge 199 Good Triplets ( Julia )

=#

using Combinatorics

 

list = [3,0,1,1,9,7]

x = 7

y = 2

z = 3

 

seen = Dict()

 

for zz in combinations(list,3)

                if ! haskey(seen,zz)

                                seen[zz] = 1

                end

end

 

for ( key,_ ) in seen

                x1 = findfirst(item -> item == key[1], list)

                x2 = findfirst(item -> item == key[2], list)

                x3 = findfirst(item -> item == key[3], list)

                if x1 > x2 || x2 > x3 || x1 > x3

                                continue

                else

                                if abs(key[1] - key[2]) > x || abs(key[2] - key[3]) > y || abs(key[1] - key[3]) > z

                                                #println(key)

                                else

                                                println(key)

                                end

                end

end

 

#=

SAMPLE OUTPUT

julia .\GoodTriplets.jl

[3, 0, 1]

[3, 1, 1]

[0, 1, 1]

=#
