#! /usr/bin/lua

function maximumproduct(lst)
   local l = lst
   table.sort(l)
   local b = #l
   local t = {}
   for i = 0, 3 do
      local p = 1
      if i > 0 then
         for j = 1, i do
            p = p * l[j]
         end
      end
      if i < 3 then
         for j = b - 2 + i, b do
            p = p * l[j]
         end
      end
      table.insert(t, p)
   end
   return math.max(table.unpack(t))
end

if maximumproduct({3, 1, 2}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumproduct({4, 1, 3, 2}) == 24 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumproduct({-1, 0, 1, 3, 1}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumproduct({-8, 2, -9, 0, -4, 3}) == 216 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

