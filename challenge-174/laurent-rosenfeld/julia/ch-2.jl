# Note: Julia array subscripts start at 1, not 0
using Combinatorics

function permute(in_list)
    return collect(permutations(sort(in_list), length(in_list)))
end

function permutation2rank(perms, input)
    for i in 1:length(perms)
        if perms[i] == input
            return i
        end
    end
end

function rank2permutation(perm_list, index)
    return perm_list[index]
end

perm_in = [3, 1, 2]
perms = permute(perm_in)
println("Permutations: ", perms)
println("Permutation ", perm_in, " -> rank ", permutation2rank(perms, perm_in))
for i in 1:length(perms)
    println("Rank: ", i, " -> permutation ", rank2permutation(perms, i))
end
