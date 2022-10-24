#!/usr/bin/env julia

using Combinatorics

function divisible_pairs( k::Int64, list::Vector{Int64} )
    ctr=0
    for i in collect(combinations(list,2))
        if (sum(i) % k == 0)
            ctr = ctr+1
        end
    end
    return ctr
end

println(divisible_pairs(2,[4,5,1,6])) #2
println(divisible_pairs(2,[1,2,3,4])) #2
println(divisible_pairs(3,[1,3,4,5])) #2
println(divisible_pairs(4,[5,1,2,3])) #2
println(divisible_pairs(4,[7,2,4,5])) #1

