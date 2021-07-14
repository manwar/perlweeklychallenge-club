#!/usr/bin/env lua

-- run <script> <space-separated numbers>

for i=1,math.min(tonumber(arg[1]),tonumber(arg[2])) do
   if (tonumber(arg[1]) % i == 0) and (tonumber(arg[2]) % i == 0) then print(i) end
end
