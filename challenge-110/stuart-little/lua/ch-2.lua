#!/usr/bin/env lua

-- run <script> <file>

local t={}
for l in io.lines(arg[1]) do
   local lt = {}
   for w in l:gmatch("[^,]+") do table.insert(lt,w) end
   table.insert(t,lt)
end

for i=1,#t[1] do
   local col = {}
   for j=1,#t do
      table.insert(col,t[j][i])
   end
   print(table.concat(col,","))
end
