#!/usr/bin/env lua

--[[
run <script> <path to file containing matrix>

e.g. copy 

   [  1,  2,  3,  4 ]
   [  5,  6,  7,  8 ]
   [  9, 10, 11, 12 ]
   [ 13, 14, 15, 16 ]

to a text file and pass that file path
--]]

function rot(t)
   if #t==0 then return {} end
   local rt={}   
   for i=#(t[1]),1,-1 do
      local row={}
      for j=1,#t do table.insert(row,t[j][i]) end
      table.insert(rt,row)
   end
   return rt
end

local mat={}

for l in io.lines(arg[1]) do
   local row={}
   for n in l:gmatch("(%d+)") do table.insert(row,n) end
   table.insert(mat,row)
end

local out={}
repeat
   local rng = table.remove(mat,1)
   if rng then
      for _,v in ipairs(rng) do table.insert(out,v) end
   end
   mat=rot(mat)
until not rng

print(table.unpack(out))
