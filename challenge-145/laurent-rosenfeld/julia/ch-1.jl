#!/usr/bin/julia

function dot_product(a1, a2)
    res = 0
    for i in eachindex(a1)
        res = res + a1[i] * a2[i]
    end
    return res
end

print( "Dot product: ", dot_product([1, 2, 3], [4, 5, 6]))
