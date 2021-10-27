#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local cache = {}

function _count (target, this_fib, prev_fib)
    local key = target .. ";" .. this_fib
    if cache [key] == nil then
            if target <  this_fib then cache [key] = 0
        elseif target == this_fib then cache [key] = 1
        else                           cache [key] =
              _count (target - this_fib, this_fib + prev_fib, this_fib) +
              _count (target,            this_fib + prev_fib, this_fib)
        end
    end
    return cache [key]
end

function count (target)
    return (_count (target, 1, 1))
end

for line in io . lines () do
    print (count (tonumber (line)))
end
