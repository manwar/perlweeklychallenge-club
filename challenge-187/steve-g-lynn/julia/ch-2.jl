#!/usr/bin/env julia

function magical_triplet(n::Vector{Float64}) ::Vector{Float64}
    

    #-- find the three biggest elements (Their sum is max)
    candidate = reverse(sort(n))[1:3]
    
    #-- test if any element is >= than the sum of the other two
    mysum=sum(candidate)
    for i in candidate
        if (mysum - i <= i)
            return Float64[]
        end
    end
         
    #-- if no element is >= the sum of the other two, we are through.
    return candidate
end


println(magical_triplet([1.,2.,3.,2.]))
#[3.0, 2.0, 2.0]

println(magical_triplet([1.,3.,2.]))
#Float64[]

println(magical_triplet([1.,1.,2.,3.]))
#Float64[]

println(magical_triplet([2.,4.,3.]))
#[4.0, 3.0, 2.0]

