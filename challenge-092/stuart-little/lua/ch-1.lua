#!/usr/bin/env lua

-- run <script> <space-separated strings>

function oneWay(s1,s2)
   local t={}
   for i=1,s1:len() do
      if i>s2:len() then return false end
      if not t[s1:sub(i,i)] then t[s1:sub(i,i)] = s2:sub(i,i) end
   end
   return s2 == s1:gsub(".",t)
end

print(oneWay(arg[1],arg[2]) and oneWay(arg[2],arg[1]) and 1 or 0)
