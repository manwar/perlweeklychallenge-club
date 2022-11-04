#!/usr/bin/env julia

#real	0m0.857s
#user	0m0.936s
#sys	0m0.369

using StatsBase

function smallest_slice_same_degree( arry::Vector{Int64} )

    #-- get first and last indices of occurrence of each element
    #-- store in dictionaries (hashes) d_first(element),
    #-- d_last(element)

    d_first=Dict{Int64,Int64}()
    d_last=Dict{Int64,Int64}()
    for i in 1:length(arry)
        d_first[arry[i]]=0
    end
    for i in 1:length(arry)
        if d_first[arry[i]] <= 0
            d_first[arry[i]] = i
        end
        d_last[arry[i]] = i
    end


    #-- get the most frequently occurring elements
    #-- using the StatsBase.modes function
    
    a_max=StatsBase.modes(arry)
    
    #-- find the minimum length among elements in a_max
    
    min_length=length(arry)
    for i in a_max
        check_length=d_last[i]-d_first[i]
        if check_length < min_length
            min_length=check_length
        end
    end
    
    #-- print the slices from first to last
    #-- for elements in a_max where these slices
    #-- are of minimum length
    
    for i in a_max
        if d_last[i]-d_first[i] == min_length
            println(arry[d_first[i]:d_last[i]])
        end
    end
end

#-- run the test examples

smallest_slice_same_degree([1,3,3,2]) #[3,3]
smallest_slice_same_degree([1,2,1,3]) #[1,2,1]
smallest_slice_same_degree([1,3,2,1,2]) #[2,1,2]
smallest_slice_same_degree([1,1,2,3,2]) #[1,1]
smallest_slice_same_degree([2,1,2,1,1]) #[1,2,1,1]
smallest_slice_same_degree([1,3,3,2,2,1])#[2,2] [3,3]

