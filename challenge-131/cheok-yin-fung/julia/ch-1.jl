tests = [
    [1, 2, 3, 6, 7, 8, 9],
    [11, 12, 14, 17, 18, 19],
    [2, 4, 6, 8],
    [1, 2, 3, 4, 5],
]



function consecutive(a)
    list = [ [ a[1] ], ]
    for i = 2:length(a)
        if a[i] == a[i-1]+1
            push!(list[end], a[i])
        else
            push!(list, [ a[i] ])
        end
    end
    return list
end



for a in tests
    println(consecutive(a))
end



# julia> include("ch-1.jl");
# [[1, 2, 3], [6, 7, 8, 9]]
# [[11, 12], [14], [17, 18, 19]]
# [[2], [4], [6], [8]]
# [[1, 2, 3, 4, 5]]
