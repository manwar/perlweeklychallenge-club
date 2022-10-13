#!/usr/bin/env julia

function myzip(a, b)
#-- there is a built-in function called zip
    if (length(a) != length(b))
        return ["ERR. Lengths unequal"]
    else 
        c=[]
        for i in 1:length(b)
            append!(c, a[i], b[i])
        end
    end
    return c
end

a=[1,2,3]
b=['a','b','c']
println(myzip(a,b))
println(myzip(b,a))

#Any[1, 'a', 2, 'b', 3, 'c']
#Any['a', 1, 'b', 2, 'c', 3]

