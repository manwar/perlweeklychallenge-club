#! /usr/bin/lua

function join(t)
   local out=""
   for k,v in pairs(t) do
      out = out .. v
   end
   return out
end

function hexwords(lo,hi,sb)
   local out = {}
   for line in io.lines("dictionary.txt") do
      if #line >= lo and #line <= hi then
         local valid = true
         local sbc = 0
         for i = 1,#line do
            local c = string.sub(line,i,i)
            if c == "o" or c == "i" or c == "l" or c == "s" or c == "t" then
               sbc = sbc + 1
               if sbc > sb then
                  valid = false
               end
            elseif c < "a" or c > "f" then
               valid = false
            end
            if not valid then
               break
            end
         end
         if valid then
            table.insert(out,line)
         end
      end
   end
   return out
end

function combiwords(wl,l)
   local wh = {}
   for k,w in pairs(wl) do
      if wh[#w] == nil then
         wh[#w] = {}
      end
      table.insert(wh[#w],w)
   end
   local tmap = { {} }
   local omap = {}
   while #tmap > 0 do
      local c = table.remove(tmap)
      local s = 0
      for k,x in pairs(c) do
         s = s + x
      end
      for j = 1, l-s-1 do
         if wh[j] ~= nil then
            local cc = {}
            for k,x in pairs(c) do
               table.insert(cc,x)
            end
            table.insert(cc,j)
            table.insert(tmap,cc)
         end
      end
      if wh[l-s] ~= nil then
         table.insert(c,l-s)
         table.insert(omap,c)
      end
   end
   local out = {}
   for k,pat in pairs(omap) do
      local c = {}
      local cm = {}
      for kk,i in pairs(pat) do
         table.insert(cm,#wh[i])
         table.insert(c,1)
      end
      local ex = false
      while not ex do
         local o = {}
         for i = 1,#c do
            table.insert(o,wh[pat[i]][c[i]])
         end
         table.insert(out,join(o,""))
         local ss = #c
         while true do
            c[ss] = c[ss] + 1
            if c[ss] > cm[ss] then
               if ss == 1 then
                  ex = true
                  break
               end
               c[ss] = 1
               ss = ss - 1
            else
               break
            end
         end
      end
   end
   return out
end

if #hexwords(2,8,8) == 1463 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if #hexwords(8,8,8) == 164 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if #hexwords(2,8,0) == 45 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if #hexwords(2,8,1) == 244 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if #combiwords(hexwords(4,4,0),8) == 144 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if #combiwords(hexwords(3,5,0),8) == 274 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
