#!/usr/bin/env lua

--[[
run <script> <file containing triangle>

for instance, copy

            1
           2 4
          6 4 9
         5 1 7 2

to a text file and pass that file's path
--]]

function clps(state,row)
   local newS={}
   for k,v in ipairs(row) do
      local val=v+((state[k] and state[k-1] and math.min(tonumber(state[k]),tonumber(state[k-1]))) or state[k] or state[k-1] or 0)
      table.insert(newS,val)
   end
   return newS
end

local state={}
local tr={}
for l in io.lines(arg[1]) do
   if l:find("%d") then
      local row={}
      for num in l:gmatch("-?%d+") do table.insert(row,num) end
      table.insert(tr,row)
   end
end

for _,v in ipairs(tr) do
   state=clps(state,v)
end

print((#state > 0) and math.min(table.unpack(state)) or 0)
