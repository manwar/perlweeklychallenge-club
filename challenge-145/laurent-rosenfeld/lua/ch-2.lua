local function is_palindrome (instr)
    return instr == string.reverse(instr)
end

local function find_palindromes (input)
    io.write (input, ": ")
    local seen = {}
    for startstr = 1, #input do
        for endstr = startstr, #input do
            local cand = string.sub (input, startstr, endstr)
            if is_palindrome(cand) and not seen[cand] then
                io.write(cand, " ")
                seen[cand] = 1
            end
        end
    end
print(" ")
end

local tests = {"redivider", "rotors", "challenge"}
for _, test in pairs(tests) do
    find_palindromes(test)
end
