#!/usr/bin/env lua

-- run <script> <number>

inpt = arg[1]
out = 0
t={0,2,1,3}

for i=1,4 do
   out = out + 4^(i-1) * t[(inpt & 3) + 1]
   inpt = inpt >> 2
end

print(string.format("%d",out))
