#! /usr/bin/lua

function luckyinteger(a)
   local c = {}
   for _, n in ipairs(a) do
      if c[n] == nil then
         c[n] = 1
      else
         c[n] = c[n] + 1
      end
   end
   local c1 = {}
   local c2 = {}
   for k, v in pairs(c) do
      table.insert(c1, v)
      table.insert(c2, k)
   end
   table.sort(c1, function (i, j) return i > j end)
   table.sort(c2, function (i, j) return i > j end)
   for _a, v1 in ipairs(c1) do
      for _b, v2 in ipairs(c2) do
         if c[v2] == v1 and v1 == v2 then
            return v2
         end
      end
   end
   return -1
end

if luckyinteger({2, 2, 3, 4}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if luckyinteger({1, 2, 2, 3, 3, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if luckyinteger({1, 1, 1, 3}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

