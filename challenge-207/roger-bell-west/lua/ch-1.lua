#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
function recursive_compare(t1,t2)
   if t1==t2 then return true end
   if (type(t1)~="table") then return false end
   local mt1 = getmetatable(t1)
   local mt2 = getmetatable(t2)
   if( not recursive_compare(mt1,mt2) ) then return false end
   for k1,v1 in pairs(t1) do
      local v2 = t2[k1]
      if( not recursive_compare(v1,v2) ) then return false end
   end
   for k2,v2 in pairs(t2) do
      local v1 = t1[k2]
      if( not recursive_compare(v1,v2) ) then return false end
   end
   return true
end

function keyboardword(wl)
   local out = {}
   for i, w in ipairs(wl) do
      local wx = string.lower(w)
      if string.match(wx, "^[qwertyuiop]+$") or
         string.match(wx, "^[asdfghjkl]+$") or
         string.match(wx, "^[zxcvbnm]+$") then
         table.insert(out, w)
      end
   end
   return out
end

if recursive_compare(keyboardword({"Hello", "Alaska", "Dad", "Peace"}), {"Alaska", "Dad"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(keyboardword({"OMG", "Bye"}), {}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

