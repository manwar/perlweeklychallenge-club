#! /usr/bin/lua

function maximumones(a)
   local ax = {}
   for i, r in ipairs(a) do
      local s = 0
      for j, t in ipairs(r) do
         s = s + t
      end
      table.insert(ax, s)
   end
   local am = math.max(table.unpack(ax))
   for i, n in ipairs(ax) do
      if n == am then
         return i
      end
   end
   return 0
end

if maximumones({{0, 1}, {1, 0}}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumones({{0, 0, 0}, {1, 0, 1}}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumones({{0, 0}, {1, 1}, {0, 0}}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

