# The Weekly Challenge Week 134
# Task 1 Pandigital Numbers
# Usage: include("ch-1.jl")

using Combinatorics

tests = [1,5,21]



function pandigital(a)   # max: a <= 40320
    if a > 40320
        println("Sorry, to keep tiny, I only handle small cases.")
        return
    end
    terms = []
    for n = 1:a
        push!(terms, join(nthperm([1,0,2,3,4,5,6,7,8,9], n), ""))
    end
    # sort!(terms)
    for n = 1:a
        println(terms[n])
    end
end



for a in tests
    pandigital(a)
    println("")
end


# julia> include("ch-1.jl");
#=    output (separate by line instead of comma)
    
    1023456789    

    1023456789, 1023456798, 1023456879,
    1023456897, 1023456978   # task requirement

    1023456789, 1023456798, 1023456879, 1023456897,
     1023456978, 1023456987, 1023457689, 1023457698,
     1023457869, 1023457896, 1023457968, 1023457986,
     1023458679, 1023458697, 1023458769, 1023458796,
     1023458967, 1023458976, 1023459678, 1023459687,
     1023459768  # OEIS showcase 
=#
