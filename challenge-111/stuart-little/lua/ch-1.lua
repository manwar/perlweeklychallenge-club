#!/usr/bin/env lua

function bSearch(x,t)
   if #t==0 then return end
   local mid = math.max(1,math.floor(#t/2))
   if x==t[mid] then return x end
   if x < t[mid] then return bSearch(x,table.pack(table.unpack(t,1,mid-1))) end
   if x > t[mid] then return bSearch(x,table.pack(table.unpack(t,mid+1))) end
end

local nrs={}
for l in io.lines(arg[2]) do
   for nr in l:gmatch("-?%d+") do table.insert(nrs,tonumber(nr)) end
end

print(bSearch(tonumber(arg[1]), nrs) and 1 or 0)

--[[ 
run <script> <number> <file containing matrix>

for instance, copy the matrix below to an input file

[  1,  2,  3,  5,  7 ]
[  9, 11, 15, 19, 20 ]
[ 23, 24, 25, 29, 31 ]
[ 32, 33, 39, 40, 42 ]
[ 45, 47, 48, 49, 50 ]
--]]
