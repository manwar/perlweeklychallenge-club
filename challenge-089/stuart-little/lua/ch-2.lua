#!/usr/bin/env lua

-- run <script>

for _,r in ipairs({{2,7,6},{9,5,1},{4,3,8}}) do
   print(table.unpack(r))
end
