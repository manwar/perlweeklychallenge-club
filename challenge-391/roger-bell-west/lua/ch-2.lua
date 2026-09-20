#! /usr/bin/lua

function arrangebox(a0)
   local a = a0
   table.sort(a, function(i, j) if i[1] == j[1] then return i[2] < j[2] else return i[1] < j[1] end end)
   local stack = {}
   local mx = 1
   for i = 1,#a do
      table.insert(stack, {i, 1})
   end
   while #stack > 0 do
      local p = table.remove(stack, #stack)
      local ix = p[1]
      local pm = p[2]
      if pm > mx then
         mx = pm
      end
      for j = ix + 1,#a do
         if a[ix][1] < a[j][1] and a[ix][2] < a[j][2] then
            table.insert(stack, {j, pm + 1})
         end
      end
   end
   return mx
end

if arrangebox({{1, 3}, {3, 5}, {6, 8}, {2, 4}}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arrangebox({{4, 5}, {4, 6}, {6, 7}, {2, 3}, {4, 3}}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arrangebox({{5, 5}, {5, 5}, {5, 5}}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arrangebox({{2, 100}, {3, 200}, {4, 300}, {5, 50}, {5, 400}}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if arrangebox({{10, 20}, {15, 10}, {20, 30}, {12, 18}, {16, 25}}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

