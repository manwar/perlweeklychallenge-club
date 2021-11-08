#!/usr/bin/env lua

-- run <script> <space-separated array entries, then ' - ', then space-separated rotation indices>

local nrs = {}
while (tonumber(arg[1])) do
   table.insert(nrs,tonumber(arg[1]))
   table.remove(arg,1)
end
table.remove(arg,1)
for _,v in ipairs(arg) do
   local vv = (v-1)%#nrs+1
   local s=table.pack(table.unpack(nrs,vv+1))
   for i=1,vv do table.insert(s,nrs[i]) end
   print(table.unpack(s))
end
