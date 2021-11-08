#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local out=#arg
for i=1,#arg-1 do
   if arg[i] ~= arg[i+1] then out=out+1 end
end
print(out)
