#!/usr/bin/env lua

--[[
Challenge 003

Challenge #1
Create a script to generate 5-smooth numbers, whose prime divisors are less
or equal to 5. They are also called Hamming/Regular/Ugly numbers. For more
information, please check this wikipedia.
--]]

-- sequence is a merge of all multiples of 2, 3 and 5
seq2 = {1}
seq3 = {1}
seq5 = {1}

function next_hamming()
    -- get the smallest of the queue heads
    local n = math.min(seq2[1], seq3[1], seq5[1])

    -- shift used multiples
    if n == seq2[1] then table.remove(seq2, 1); end
    if n == seq3[1] then table.remove(seq3, 1); end
    if n == seq5[1] then table.remove(seq5, 1); end

    -- push next multiples
    table.insert(seq2, 2*n)
    table.insert(seq3, 3*n)
    table.insert(seq5, 5*n)

    return n
end

for i=1,tonumber(arg[1]) do
    io.write(next_hamming(), "\n")
end
