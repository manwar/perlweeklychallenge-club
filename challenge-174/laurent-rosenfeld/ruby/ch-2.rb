def permute(in_list)
    return in_list.sort.permutation(in_list.length).to_a
end

def permutation2rank(perms, input)
    for i in 0..perms.length - 1
        if perms[i] == input
            return i
        end
    end
end

def rank2permutation(perms, index)
    return perms[index]
end

perm_in = [3, 1, 2]
perms = permute(perm_in)
puts("Permutations: #{perms} \n")
print("Permutation #{perm_in} -> rank  #{permutation2rank(perms, perm_in)} \n")
for i in 1..perms.length - 1
    print("Rank:  #{i} -> permutation  #{rank2permutation(perms, i)} \n")
end
