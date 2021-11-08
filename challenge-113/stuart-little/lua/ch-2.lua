#!/usr/bin/env lua

require 'luarocks.loader'
local inspect = require 'inspect'

sm=0
for _,v in ipairs(arg) do
   if v ~= "." then sm=sm+v end
end
for k,v in ipairs(arg) do
   if v ~= "." then arg[k]=("%d"):format(sm-v) end
end

function oneOver(t)
   local count=0
   for k,v in ipairs(t) do
      count = count + (v == "." and 1 or -1)
      if count == 1 then return k end
   end
end

function strs2t(lst)
   if lst[1] == "." then return end
   local val=table.remove(lst,1)
   local ix=oneOver(lst)
   local llst = {table.unpack(lst,1,ix)}
   local rlst = {table.unpack(lst,ix+1)}
   return {{val},l=strs2t(llst),r=strs2t(rlst)}
end

print(inspect(strs2t(arg)))

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
