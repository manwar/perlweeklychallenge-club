#!/usr/bin/env julia

using StatsBase

function most_frequent_even( mylist::Vector{Int64} )::Int64
    evens = mylist[mylist .% 2 .== 0]
    
    if length(evens)==0
        return -1
    end
    
    d_freq = countmap(evens) #-- a dictionary (hash)
    
    max_freq=maximum(values(d_freq))
    
    retval = Vector{Int64}() 
    
    for i in keys(d_freq)
        if d_freq[i] == max_freq
            push!(retval, i)
        end
    end
        
    return minimum(retval)     
end


println(most_frequent_even([1,1,2,6,2])) #2
println(most_frequent_even([1,3,5,7])) #-1
println(most_frequent_even([6,4,4,6,1])) #4

