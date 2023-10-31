#! /usr/bin/lua

function arithmetictriplets(ints, diff)
   local vs = {}
   for _i, c in ipairs(ints) do
      vs[c] = true
   end
   local n = 0
   for _ai, s in ipairs(ints) do
      if vs[s + diff] ~= nil and vs[s + diff * 2] ~= nil then
         n = n + 1
      end
   end
   return n
end

if arithmetictriplets({0, 1, 4, 6, 7, 10}, 3) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arithmetictriplets({4, 5, 6, 7, 8, 9}, 2) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

