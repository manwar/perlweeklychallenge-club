#!/usr/bin/env lua

--[[
Challenge 123

TASK #1 > Ugly Numbers
Submitted by: Mohammad S Anwar
You are given an integer $n >= 1.

Write a script to find the $nth element of Ugly Numbers.

Ugly numbers are those number whose prime factors are 2, 3 or 5. For example,
the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.

Example
Input: $n = 7
Output: 8

Input: $n = 10
Output: 12
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
