#!/usr/bin/env lua

-- run <script> <comma-separated numbers, space, comma-separated indices>

function splt(s)
   local t={}
   for n in s:gmatch("(%d+)") do table.insert(t,tonumber(n)) end
   return(t)
end

function getSl(ar,ixs)
   local slc={}
   for k=#ixs,1,-1 do
      table.insert(slc,table.remove(ar,ixs[k]+1))
   end
   return slc
end

function insMult(ar,ixs,slc)
   for _,ix in ipairs(ixs) do
      local val=table.remove(slc,1)
      table.insert(ar,ix+1,val)
   end
end

local ar,ixs = splt(arg[1]),splt(arg[2])
local slc=getSl(ar,ixs)
table.sort(slc)
insMult(ar,ixs,slc)
print(table.unpack(ar))
