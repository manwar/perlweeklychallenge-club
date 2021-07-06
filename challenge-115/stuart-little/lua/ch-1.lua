#!/usr/bin/env lua

-- run <script> <space-separated strings>

t={}

for _,s in ipairs(arg) do
   t[s:sub(1,1)] = (t[s:sub(1,1)] or 0)+1
   t[s:sub(-1)] = (t[s:sub(-1)] or 0)-1
end

for _,v in pairs(t) do
   if v ~= 0 then
      print(0)
      os.exit()
   end
end

print((#arg < 2) and 0 or 1)
   
