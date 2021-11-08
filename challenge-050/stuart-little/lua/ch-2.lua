#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local inpt={}
for _,v in ipairs(arg) do
   table.insert(inpt,tonumber(v))
end
table.sort(inpt)
for k,v in ipairs(inpt) do
   if v==#inpt-k and (k==#inpt or inpt[k+1]>v) then print(v) end
end
