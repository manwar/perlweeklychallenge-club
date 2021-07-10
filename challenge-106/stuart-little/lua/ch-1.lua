#!/usr/bin/env lua

-- run <script> <space-separated numbers>

t={}
for _,v in ipairs(arg) do
   table.insert(t,v)
end
table.sort(t)
maxDiff=0
for k,v in ipairs(t) do
   if (t[k+1] and t[k+1]-t[k] > maxDiff) then
      maxDiff = t[k+1]-t[k]
   end
end
print(("%d"):format(maxDiff))
