#!/usr/bin/env lua

--[[
run <script> <initial ordered intervals followed by extra interval>

each interval should be entered as <left> <space> <right>, with spaces between the individual intervals

e.g. <script> 1 4 8 10 2 6
--]]

function lt(t1,t2)
   return t1 and t2 and t1[2] < t2[1]
end

function overlap(t1,t2)
   return t1 and t2 and t1[2] >= t2[1] and t2[2] >= t1[1]
end

function mergeOver(t1,t2)
   return {math.min(t1[1],t2[1]),math.max(t1[2],t2[2])}
end

local ints={}
while #arg>0 do
   table.insert(ints,{tonumber(table.remove(arg,1)),tonumber(table.remove(arg,1))})
end
extra=table.remove(ints)

local i=1
while lt(ints[i],extra) do i=i+1 end
while overlap(ints[i],extra) do
   local t=table.remove(ints,i)
   extra=mergeOver(extra,t)
end
table.insert(ints,i,extra)
for _,t in ipairs(ints) do print(table.unpack(t)) end
