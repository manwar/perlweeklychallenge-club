#!/usr/bin/env lua

--[[
Challenge 098

TASK #1 › Read N-characters
Submitted by: Mohammad S Anwar
You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and
moves the pointer to the (n+1)th character.

Example:
Input: Suppose the file (input.txt) contains "1234567890"
Output:
    print readN("input.txt", 4); # returns "1234"
    print readN("input.txt", 4); # returns "5678"
    print readN("input.txt", 4); # returns "90"
--]]

files = {}

function readN(filename, n)
    local file = files[filename]

    if file == nil then         -- file not yet open
        file = io.open(filename, "r")
        files[filename] = file
    end
    local text = ""
    for i=1,n do
        local c = file:read(1)
        if c ~= nil then
            text = text..c
        end
    end
    return text
end

for i=1, #arg-1, 2 do
    text = readN(arg[i], arg[i+1])
    io.write(text, "\n")
end
