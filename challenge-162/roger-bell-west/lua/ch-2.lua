#! /usr/bin/lua

function encrypt(kw,plaintext)
   return playfair(1,kw,plaintext)
end

function decrypt(kw,plaintext)
   return playfair(-1,kw,plaintext)
end

function playfair(dir,kwi0,input)
   local kwi=string.lower(kwi0)
   for cc = string.byte("a"),string.byte("z") do
      kwi = kwi .. string.char(cc)
   end
   local kw = ""
   local k = {}
   for char in string.gmatch(kwi,"(%l)") do
      if char == "j" then
         char = "i"
      end
      if k[char] == nil then
         k[char] = true
         kw = kw .. char
      end
   end
   local grid = {}
   local gc = {}
   local index = 1
   for row = 0,4 do
      local r = {}
      for column = 0,4 do
         local cc=string.sub(kw,index,index)
         table.insert(r,cc)
         gc[cc] = {row,column}
         index = index + 1
      end
      table.insert(grid,r)
   end
   local ii = string.gsub(string.gsub(string.lower(input),"%L+",""),"j","i")
   local iil = string.len(ii)
   local out = ""
   index = 1
   while index <= iil do
      local ca = string.sub(ii,index,index)
      local cb = "x"
      if index+1 <= iil then
         cb = string.sub(ii,index+1,index+1)
      end
      index = index + 2
      if ca == cb then
         cb = "x"
         index = index - 1
      end
      local car = gc[ca][1]
      local cac = gc[ca][2]
      local cbr = gc[cb][1]
      local cbc = gc[cb][2]
      local oar = car
      local oac = cac
      local obr = cbr
      local obc = cbc
      if car == cbr then
         oac = posmod(cac+dir,5)
         obc = posmod(cbc+dir,5)
      elseif cac == cbc then
         oar = posmod(car+dir,5)
         obr = posmod(cbr+dir,5)
      else
         oac = cbc
         obc = cac
      end
      out = out .. grid[oar + 1][oac + 1]
      out = out .. grid[obr + 1][obc + 1]
   end
   return out
end

function posmod(a,b)
   local m = a % b
   while m < 0 do
      m = m + b
   end
   return m
end

if encrypt("playfair example","hide the gold in the tree stump") == "bmodzbxdnabekudmuixmmouvif" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if decrypt("perl and raku","siderwrdulfipaarkcrw") == "thewexeklychallengex" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
