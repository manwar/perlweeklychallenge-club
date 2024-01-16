#! /usr/bin/lua

function luckynumbers(a)
   local maxs = {}
   for x = 1, #(a[1]) do
      local max = {0, 0, 0}
      for y = 1, #a do
         if a[y][x] > max[1] then
            max = {a[y][x], y, x}
         end
      end
      table.insert(maxs, max)
   end
   local mins = {}
   for y = 1, #a do
      local min = {a[y][1], y, 1}
      for x = 1, #(a[1]) do
         if a[y][x] < min[1] then
            min = {a[y][x], y, x}
         end
      end
      table.insert(mins, min)
   end
   for i, v in ipairs(mins) do
      for j, w in ipairs(maxs) do
         if v[1] == w[1] and v[2] == w[2] and v[3] == w[3] then
            return v[1]
         end
      end
   end
   return -1
end

if luckynumbers({{3, 7, 9}, {9, 11, 13}, {15, 16, 17}}) == 15 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if luckynumbers({{1, 10, 4, 2}, {9, 3, 8, 7}, {15, 16, 17, 12}}) == 12 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if luckynumbers({{7, 8}, {1, 2}}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

