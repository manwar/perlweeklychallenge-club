#! /usr/bin/lua

function boomerang(a)
   local delta = {}
   -- coincident points
   for ij = 1, 2 do
      for ik = ij + 1, 3 do
         if a[ij][1] == a[ik][1] and a[ij][2] == a[ik][2] then
            return false
         end
      end
      table.insert(delta, {a[ij + 1][1] - a[1][1], a[ij + 1][2] - a[1][2]})
   end
   -- all on the same vertical line
   if delta[1][1] == 0 and delta[2][1] == 0 then
      return false
   end
   -- just one vertical line
   if delta[1][1] == 0 or delta[2][1] == 0 then
      return true
   end
   local m = delta[1][2] / delta[1][1]
   local c = a[1][2] - a[1][1] * m
   return a[3][2] ~= a[3][1] * m + c
end

if boomerang({{1, 1}, {2, 3}, {3, 2}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not boomerang({{1, 1}, {2, 2}, {3, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if boomerang({{1, 1}, {1, 2}, {2, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not boomerang({{1, 1}, {1, 2}, {1, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not boomerang({{1, 1}, {2, 1}, {3, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if boomerang({{0, 0}, {2, 3}, {4, 5}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

