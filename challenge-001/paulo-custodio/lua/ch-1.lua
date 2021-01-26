#!/usr/bin/env lua

--[[
Challenge 001

Challenge #1
Write a script to replace the character ‘e’ with ‘E’ in the string
‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
is found in the string.
--]]

count = 0
words = {}
for i=1, #arg do
    word, n = string.gsub(arg[i], "e", "E");
    table.insert(words, word)
    count = count+n
end

io.write(count, " ", table.concat(words, " "), "\n")
