#! /usr/bin/lua

function windowed(a, n)
   local out = {}
   for i = 1, #a - n + 1 do
      local t = {}
      for j = i, i + n - 1 do
         table.insert(t, a[j])
      end
      table.insert(out, t)
   end
   return out
end

function oddsum(a)
   local out = 0
   local l = 1
   while l <= #a do
      for _i, s in ipairs(windowed(a, l)) do
         for _j, nn in ipairs(s) do
            out = out + nn
         end
      end
      l = l + 2
   end
   return out
end
   

if oddsum({2, 5, 3, 6, 4}) == 77 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddsum({1, 3}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

