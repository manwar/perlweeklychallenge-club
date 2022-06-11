# The Weekly Challenge 163
# Task 2 Summation
# Julia Solution

function compute(arr)
    v = arr
    NUM = length(arr)
    if NUM == 1
        return v[1]
    end
    new_v = []

    for r in 1:(NUM-1)
        new_v = []
        push!(new_v, v[2])
        for nxt in 2:(NUM-r)
            push!( new_v, new_v[nxt-1]+v[nxt+1] )
        end
        v = new_v
    end
    return new_v[1]
end

print(compute([1,2,3,4,5]))
println()
print(compute([1,3,5,7,9]))
println()
