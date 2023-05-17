#! /usr/bin/lua

function sortedmatrix(matrix)
   local n = {}
   for _a, v1 in ipairs(matrix) do
      for _b, v2 in ipairs(v1) do
         table.insert(n, v2)
      end
   end
   table.sort(n)
   return n[3]
end

if sortedmatrix({{3, 1, 2}, {5, 2, 4}, {0, 1, 3}}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortedmatrix({{2, 1}, {4, 5}}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortedmatrix({{1, 0, 3}, {0, 0, 0}, {1, 2, 1}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

