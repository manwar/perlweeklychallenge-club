#! /usr/bin/lua

function mostfrequenteven(l)
   local f = {}
   local mx
   for i, n in ipairs(l) do
      if n % 2 == 0 then
         if f[n] == nil then
            f[n] = 1
         else
            f[n] = f[n]+1
         end
         if mx == nil or f[n] > mx then
            mx = f[n]
         end
      end
   end
   if mx ~= nil then
      local l = {}
      for k, v in pairs(f) do
         if v == mx then
            table.insert(l, k)
         end
      end
      table.sort(l)
      return l[1]
   else
      return -1
   end
end

if mostfrequenteven({1, 1, 2, 6, 2}) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if mostfrequenteven({1, 3, 5, 7}) == -1 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if mostfrequenteven({6, 4, 4, 6, 1}) == 4 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
