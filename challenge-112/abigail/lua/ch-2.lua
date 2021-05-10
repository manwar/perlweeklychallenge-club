#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local cache = {}
cache [0] = 1
cache [1] = 1

function fib (n)
    if cache [n] == nil
    then cache [n] = fib (n - 1) + fib (n - 2)
    end
    return cache [n]
end

for line in io . lines () do
    print (fib (tonumber (line)))
end
