#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function _count (target, this_fib, prev_fib)
    if target <  this_fib then return 0 end
    if target == this_fib then return 1 end
    return (_count (target - this_fib, this_fib + prev_fib, this_fib) +
            _count (target,            this_fib + prev_fib, this_fib))
end

function count (target)
    return (_count (target, 1, 1))
end

for line in io . lines () do
    print (count (tonumber (line)))
end
