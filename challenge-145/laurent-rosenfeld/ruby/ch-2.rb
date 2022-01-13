def is_palindrome (instr)
    return instr == instr.reverse
end

def find_palindromes (input)
    print input, ": "
    seen = {}
    for start in 0 .. input.length - 1 do
        for endstr in start .. input.length - 1 do
            cand = input[start .. endstr]
            if is_palindrome(cand) and not seen[cand] then
                print cand, " "
                seen[cand] = 1
            end
        end
    end
    puts " "
end

for test in ["redivider", "rotors", "challenge"] do
    find_palindromes(test)
end
