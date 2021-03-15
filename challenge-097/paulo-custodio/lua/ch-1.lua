#!/usr/bin/env lua

--[[
Challenge 097

TASK #1 › Caesar Cipher
Submitted by: Mohammad S Anwar
You are given string $S containing alphabets A..Z only and a number $N.

Write a script to encrypt the given string $S using Caesar Cipher with left
shift of size $N.

Example
Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"

Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW

Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD
--]]

function caesar(n, text)
    local text = string.upper(text)
    local cipher = ""

    for i=1, #text do
        local c = string.sub(text,i,i)
        if c >= "A" and c <= "Z" then
            c = string.char((string.byte(c)-string.byte('A')+26-n)%26
                            +string.byte('A'))
        end
        cipher = cipher..c
    end
    return cipher
end

n = arg[1]
text = ""; for i=2,#arg do text = text..arg[i].." "; end
io.write(caesar(n, text),"\n")
