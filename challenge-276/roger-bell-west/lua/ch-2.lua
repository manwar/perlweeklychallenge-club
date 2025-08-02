#! /usr/bin/lua

function maximumfrequency(a)
   local c = {}
   for _, n in ipairs(a) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   local v = {}
   for _, n in pairs(c) do
      table.insert(v, n)
   end
   local mx = math.max(table.unpack(v))
   local out = 0
   for _, n in ipairs(v) do
      if n == mx then
         out = out + mx
      end
   end
   return out
end

if maximumfrequency({1, 2, 2, 4, 1, 5}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumfrequency({1, 2, 3, 4, 5}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

