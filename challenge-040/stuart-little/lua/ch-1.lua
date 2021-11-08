#!/usr/bin/env lua

--[[
run <script> <path to file containing arrays, one per line>

e.g. copy 

I L O V E Y O U
2 4 0 3 2 0 1 9 
! ? £ $ % ^ & *

to a text file
--]]

function transpose(t)
   local tt={}
   if #t==0 then return {} end
   for j=1,#(t[1]) do
      local row={}
      for i=1,#t do
	 table.insert(row,t[i][j])
      end
      table.insert(tt,row)
   end
   return tt
end

local inpt={}
for l in io.lines(arg[1]) do
   if l:match("%S") then
      local row={}
      for w in l:gmatch("(%S+)") do
	 table.insert(row,w)
      end
      table.insert(inpt,row)
   end
end

for _,v in ipairs(transpose(inpt)) do
   print(table.unpack(v))
end
