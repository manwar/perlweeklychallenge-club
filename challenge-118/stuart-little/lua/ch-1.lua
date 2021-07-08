#!/usr/bin/env lua

-- run <script> <number>

inpt = tonumber(arg[1])
rev = 0
while inpt > 0 do
   rev = (rev << 1) + (inpt & 1)
   inpt = inpt >> 1
end
print(tostring(rev) == arg[1] and 1 or 0)
