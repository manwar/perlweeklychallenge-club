function is_palin(instr)
    return instr == reverse(instr)
end

function find_all_palindromes(input)
    print("$input: ")
    seen = Dict()
    for startstr in 1:length(input)
        for endstr in startstr:length(input)
            cand = input[startstr:endstr]  # candidate
            if is_palin(cand) && cand ∉ keys(seen)
                print("$cand ")
                seen[cand] = 1
            end
        end
    end
    print("\n")
end

for test in ("redivider", "rotors", "deific", "challenge")
    find_all_palindromes(test)
end
