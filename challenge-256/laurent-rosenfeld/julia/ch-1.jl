using Printf

function find_pairs(in)
    nb_pairs = 0
    for i in 1:size(in, 1)
        for j in i+1:size(in, 1)
            if in[i] == reverse(in[j])
                nb_pairs += 1
            end
        end
    end
    return nb_pairs
end

tests = [ ["ab", "de", "ed", "bc"],
          ["aa", "ba", "cd", "ed"],
          ["uv", "qp", "st", "vu", "mn", "pq"] ]

for test in tests
    @printf "%-40s => " "$test"
    println(find_pairs(test))
end
