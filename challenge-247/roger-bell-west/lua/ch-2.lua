#! /usr/bin/lua

function mostfrequentletterpair(s)
   local f = {}
   local m = 0
   for i = 0,string.len(s) - 1 do
      pair = string.sub(s, i, i + 1)
      if f[pair] == nil then
         f[pair] = 1
      else
         f[pair] = f[pair] + 1
         if f[pair] > m then
            m = f[pair]
         end
      end
   end
   local l = {}
   for k, v in pairs(f) do
      if v == m then
         table.insert(l, k)
      end
   end
   table.sort(l)
   return l[1]
end

if mostfrequentletterpair("abcdbca") == "bc" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mostfrequentletterpair("cdeabeabfcdfabgcd") == "ab" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

