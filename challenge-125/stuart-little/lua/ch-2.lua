#!/usr/bin/env lua

function maxBy(fn,t)
   local mx,val = -math.huge,nil
   for k,v in ipairs(t) do
      if fn(v,k,t) > mx then
	 mx = fn(v,k,t)
	 val = v
      end
   end
   return val
end

function lr(tree) 
   if #tree < 3 or tree[1] == '.' then return {{},{}} end
   if #tree == 3 then return {{"."},{"."}} end
   local left={}
   local sm,ix = 0,2
   while (sm ~= -1) do
      table.insert(left,tree[ix])
      sm = sm+(tree[ix] == '.' and -1 or 1)
      ix = ix+1
   end
   return {left,table.pack(table.unpack(tree, #left+2))}
end

function lrLongPath(tree) 
   if tree[1] == '.' then return {{},{}} end
   if #tree == 3 then return {{tree[1]},{tree[1]}} end
   local left,right = table.unpack(lr(tree))
   local lPath = table.pack(tree[1], table.unpack(maxBy(function(v,k,t) return #v end, lrLongPath(left))))
   local rPath = table.pack(tree[1], table.unpack(maxBy(function(v,k,t) return #v end, lrLongPath(right))))
   return {lPath,rPath}
end

function biLongPath(tree) 
   if #tree < 3 or tree[1] == '.' then return {} end
   if #tree == 3 then return {tree[1]} end
   local lPath,path = table.unpack(lrLongPath(tree))
   for i=2,#lPath do table.insert(path,1,lPath[i]) end   
   local left,right = table.unpack(lr(tree))
   return maxBy(function(v,k,t) return #v end, {path, biLongPath(left), biLongPath(right)})
end

print(table.unpack(biLongPath(arg)))

--[[
run <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . 7 . . . 3 5 . . 6 . . represents the tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
--]]
