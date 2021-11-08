#!/usr/bin/env lua

-- run <script> <nr of cities>

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

function mkRMat(n)
   math.randomseed(os.time())
   local t={}
   for i=1,n do
      local row={}
      for j=1,n do
	 table.insert(row,(i==j) and 0 or math.random(1,9))
      end
      table.insert(t,row)
   end
   return t
end

function sayMat(mat)
   for _,row in ipairs(mat) do
      print(table.unpack(row))
   end
end

function pathCost(pth,mat)
   local sm=0
   for i=1,#pth do
      sm = sm+mat[pth[i]][pth[(i+1) <= #pth and (i+1) or 1]]
   end
   return sm
end

local nr = tonumber(arg[1])
local mat = mkRMat(nr)

print("Your matrix:")
sayMat(mat)

local rng={}
for i=1,nr do table.insert(rng,i) end
local sol={rng,pathCost(rng,mat)}

local perms=permute(rng)
for _,p in ipairs(perms) do
   local newC=pathCost(p,mat)
   if newC < sol[2] then sol={p,newC} end
end

print("Optimal cost: "..sol[2])
print("Optimal path: "..table.concat(sol[1]," ").." "..sol[1][1])
