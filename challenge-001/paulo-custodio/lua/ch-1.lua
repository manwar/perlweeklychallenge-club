#!/usr/bin/env lua

--[[
Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
https://theweeklychallenge.org/blog/perl-weekly-challenge-001/
--]]

count = 0
words = {}
for i=1, #arg do
    word, n = string.gsub(arg[i], "e", "E");
    table.insert(words, word)
    count = count+n
end

io.write(count, " ", table.concat(words, " "), "\n")
