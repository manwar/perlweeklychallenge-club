using Printf

function count_smaller(input)
    result = []
    for i in input
        count = 0
        for j in input
            if j < i
                count += 1
            end
        end
        push!(result, count)
    end
    return join(result, " ");
end

tests = [ [5, 2, 1, 6], [1, 2, 0, 3], [0, 1], [9, 4, 9, 2] ]

for test in tests
    @printf "%-15s => " "$test"
    println("$(count_smaller(test))")
end
