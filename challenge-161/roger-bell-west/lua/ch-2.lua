#! /usr/bin/lua

function join(t,pad)
   local out=""
   local later = false
   for k,v in pairs(t) do
      if later then
         out = out .. pad
      end
      out = out .. v
      later = true
   end
   return out
end

local f = {}
local r = {}

while true do
   local line = io.read()
   if line == nil then break end
   local b = 1
   local v = 0
   for l = string.byte("a"), string.byte("z") do
      local lx = string.char(l)
      if string.find(line,lx,1,true) ~= nil then
         v = v | b
      end
      b = b << 1
   end
   if r[v] == nil or (#r[v] > #line) then
      f[line] = v
      r[v] = line
   end
end

local w = {}
local lt = (1 << 26) - 1
local lu = {0}
while lu[#lu] ~= lt do
   local wn = ""
   if #w > 0 then
      local mode = 0
      local sc = {}
      for wv,dummy in pairs(r) do
         if (wv & lu[#lu]) == 0 then
            if mode == 0 then
               mode = 1
               sc = {}
            end
            table.insert(sc,r[wv])
         elseif mode == 0 and (wv | lu[#lu]) ~= lu[#lu] then
            table.insert(sc,r[wv])
         end
      end
      if #sc == 0 then
         table.remove(w,#w)
         table.remove(lu,#lu)
      else
         wn = sc[math.random(#sc)]
      end
   else
      local sc = {}
      for k,dummy in pairs(f) do
         table.insert(sc,k)
      end
      wn = sc[math.random(#sc)]
   end
   if wn ~= "" then
      table.insert(w,wn)
      table.insert(lu,lu[#lu] | f[wn])
   end
end

print(join(w," "))
