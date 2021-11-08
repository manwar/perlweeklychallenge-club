#!/usr/bin/env lua

-- run <script> <file>

require('luarocks.loader')
local re = require('re')

for l in io.lines(arg[1]) do
   local mtch = table.pack(re.match(l, "({'+'%d^2%s+%d^10 / '('%d^2')'%s+%d^10 / %d^4%s+%d^10/.})*"))
   for _,v in ipairs(mtch) do
      if v:len() > 1 then print(v) end 
   end
end
