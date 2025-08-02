#! /usr/bin/lua

function thirdmaximum(a)
   local q = {}
   for i, n in ipairs(a) do
      q[n] = true
   end
   local p = {}
   for k, v in pairs(q) do
      table.insert(p, k)
   end
   table.sort(p, function (i, j) return i > j end)
   if #p > 2 then
      return p[3]
   else
      return p[1]
   end
end

if thirdmaximum({5, 6, 4, 1}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thirdmaximum({4, 5}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if thirdmaximum({1, 2, 2, 3}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

