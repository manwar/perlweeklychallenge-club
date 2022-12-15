#!/usr/bin/env julia

function special_integers( n::Int64 ) ::Int64
    ctr=0
    for i in 1:n
        if length(digits(i)) == length(unique(digits(i)))
            ctr += 1
        end
    end
    return ctr
end

println(special_integers(15))
println(special_integers(35))

