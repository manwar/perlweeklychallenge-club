#!/usr/bin/env lua

-- run <script> <number>

local nr,state=0,arg[1]:sub(1,1)
local out = ""

for i=1,arg[1]:len()+1 do
   if arg[1]:sub(i,i) ~= state then
      out = out .. nr .. state
      nr=0
      state=arg[1]:sub(i,i)
   end
   nr=nr+1
end

print(out)
