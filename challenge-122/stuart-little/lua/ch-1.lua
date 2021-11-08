#!/usr/bin/env lua

-- run <script> <space-separated numbers>

function runAvg(t)
   local avgs={0}
   for k,v in ipairs(t) do
      local newAvg = (avgs[#avgs]*(k-1)+tonumber(v))/k
      table.insert(avgs,newAvg)
   end
   table.remove(avgs,1)
   return avgs
end

print(table.unpack(runAvg(arg)))
