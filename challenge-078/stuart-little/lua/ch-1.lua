#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local mx = tonumber(arg[#arg])
local out = {mx}
for i=#arg-1,1,-1 do
   if tonumber(arg[i]) > mx then
      mx = tonumber(arg[i])
      table.insert(out,1,mx)
   end
end
print(table.unpack(out))
