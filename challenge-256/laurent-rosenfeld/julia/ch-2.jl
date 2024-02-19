using Printf

function merge_strings(str1, str2)
    result = []
    let1 = split(str1, "")
    let2 = split(str2, "")
    size1 = size(let1, 1)
    size2 = size(let2, 1)
    last_i = size1 > size2 ? size2 : size1
    for i in 1:last_i
        push!(result, let1[i], let2[i])
    end
    if size1 > size2
        for i in last_i + 1:size1
            push!(result, let1[i])
        end
    else
        for i in last_i + 1:size2
            push!(result, let2[i])
        end
    end
    return join(result, "");
end

tests = [["abcd", "1234"], ["abc", "12345"], ["abcde", "123"]]
for test in tests
    @printf "%-18s => " "$test"
    println(merge_strings(test[1], test[2]))
end
