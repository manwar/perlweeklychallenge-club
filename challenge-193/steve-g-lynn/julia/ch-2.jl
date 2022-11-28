#!/usr/bin/env julia

function codehash(a::SubString{String}) ::Int64
    ctr=0
    for i in 'a':'z'
        if only(a)==i
            return ctr+1
        else
            ctr=ctr+1
        end
    end
end

function difference_array(a::String) ::Vector{Int64}
    retval=Vector{Int64}()
    a_vec=split(a,"")
    for i in 2:length(a)
        push!(retval,codehash(a_vec[i])-codehash(a_vec[i-1]))
    end
    return retval
end

function difference_array(a::Vector{String}) ::Matrix{Int64}
    retval=Array{Int64}(undef,0,2)
    for i in a
        retval=[retval;difference_array(i)']
    end
    return retval
end

function mybag(a::Matrix{Int64}) ::Dict{Vector{Int64},Int64}
    retval=Dict{Vector{Int64},Int64}()
    for i in eachrow(a) #rows
        retval[i] = 0
        #-- unpleasant need to initialize hash keys before counting
    end
    for i in eachrow(a) #rows
        retval[i] += 1
    end
    return retval
end

function odd_string(a::Matrix{Int64}) ::Int64
    mybag_a=mybag(a)
    ctr=0
    for i in eachrow(a)
    #-- that makes 3 loops thru' a at least :-)
        ctr += 1
        if mybag_a[i]==1
            return ctr
        end
    end
end    

function odd_string(a::Vector{String}) ::String
    myindx=odd_string(difference_array(a))
    return a[myindx]
end    

println(odd_string(["adc","wzy","abc"]))
println(odd_string(["aaa","bob","ccc","ddd"]))
  
