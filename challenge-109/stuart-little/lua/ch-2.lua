#!/usr/bin/env lua

-- run <script> <space-separated numbers>

--[[
Heap's algorithm for generating permutations

Refs:

[0] https://stackoverflow.com/a/37580979/11064961
[1] https://en.m.wikipedia.org/wiki/Heap's_algorithm
--]]

function permute(arr) 
  local length = #arr
  local result = {table.pack(table.unpack(arr))}
  local c,i,k,p = {},1
  for j=1,length do table.insert(c,1) end

  while (i <= length) do
    if (c[i] < i) then
       k = (i % 2==1) and 1 or c[i]
       p = arr[i]
       arr[i] = arr[k]
       arr[k] = p
       c[i] = c[i]+1
       i = 2
       table.insert(result,table.pack(table.unpack(arr)))
    else 
       c[i] = 1
       i=i+1
    end
  end
  return result
end

function sum(t)
   local sm=0
   for _,v in ipairs(t) do sm=sm+v end
   return sm
end

function allSumsEq(t)
   if #t <= 3 then return true end
   local s=t[1]+t[2]
   for i=2,#t,2 do
      if sum(table.pack(table.unpack(t,i,i+2))) ~= s then return false end
   end
   return true
end

local perms = permute(arg)
for _,p in ipairs(perms) do
   if allSumsEq(p) then
      print("Solution: "..table.concat(p," "))
      print("Sum: "..p[1]+p[2])
   end
end
