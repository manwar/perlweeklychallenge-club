#! /usr/bin/lua

function nearestvalidpoint(x, y, points)
   local ix = -1
   local minmhd = -1
   for i, p in ipairs(points) do
      if p[1] == x or p[2] == y then
         local mhd = math.abs(p[1] - x) + math.abs(p[2] - y)
         if minmhd == -1 or mhd < minmhd then
            minmhd = mhd
            ix = i - 1
         end
      end
   end
   return ix
end

if nearestvalidpoint(3, 4, {{1, 2}, {3, 1}, {2, 4}, {2, 3}}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if nearestvalidpoint(2, 5, {{3, 4}, {2, 3}, {1, 5}, {2, 5}}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if nearestvalidpoint(1, 1, {{2, 2}, {3, 3}, {4, 4}}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if nearestvalidpoint(0, 0, {{0, 1}, {1, 0}, {0, 2}, {2, 0}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if nearestvalidpoint(5, 5, {{5, 6}, {6, 5}, {5, 4}, {4, 5}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

