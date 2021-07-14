#!/usr/bin/env lua

-- run <script> <space-separated strings, with the target string last>

function canInterleave(a,b,c)
   if math.max(a:len(),b:len(),c:len()) == 0 then return true end
   if a:sub(1,1) == c:sub(1,1) then return canInterleave(a:sub(2),b,c:sub(2)) end
   if b:sub(1,1) == c:sub(1,1) then return canInterleave(a,b:sub(2),c:sub(2)) end
   return false
end
print(canInterleave(table.unpack(arg,1,3)) and 1 or 0)
