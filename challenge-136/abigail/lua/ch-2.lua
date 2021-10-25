#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function count (target, this_fib, prev_fib)
    if target <  this_fib then return 0 end
    if target == this_fib then return 1 end
    return (count (target - this_fib, this_fib + prev_fib, this_fib) +
            count (target,            this_fib + prev_fib, this_fib))
end

for line in io . lines () do
    print (count (tonumber (line), 1, 1))
end
