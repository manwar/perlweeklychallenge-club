#!/usr/bin/env lua

-- run <script> <number>
-- https://oeis.org/A000788

function bitsUpTo(n)
   if n <= 1 then return n end
   local topBitPos = math.floor(math.log(n,2))
   local rest = n ~ 2^topBitPos
   return 1+topBitPos*2^(topBitPos-1) + rest + bitsUpTo(rest)
end

print(("%d"):format(bitsUpTo(tonumber(arg[1]))))
