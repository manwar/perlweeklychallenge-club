#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local out,run={}
for k,v in ipairs(arg) do
   table.insert(out,(((not run) and 0) or (tonumber(v)<=run and 0) or (run)))
   run=run and run <= tonumber(v) and run or tonumber(v)
end

print(table.unpack(out))
