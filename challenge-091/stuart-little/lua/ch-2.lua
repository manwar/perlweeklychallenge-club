#!/usr/bin/env lua

-- run <script> <space-separated numbers>

local nr=1
while true do
   nr=nr+arg[nr]
   if arg[nr] == nil then
      print(1)
      os.exit()
   end
   if tonumber(arg[nr])==0 then
      print(0)
      os.exit()
   end
end
