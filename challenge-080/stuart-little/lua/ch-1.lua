#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local out = 1
for _,v in ipairs(arg) do
   if tonumber(v) == out then out=out+1 end
end
print(out)
