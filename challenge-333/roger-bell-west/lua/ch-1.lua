#! /usr/bin/lua

function straightline(a)
   local b = {}
   for _, xy in ipairs(a) do
      local u = true
      for __, bxy in ipairs(b) do
         if xy[1] == bxy[1] and xy[2] == bxy[2] then
            u = false
            break
         end
      end
      if u then
         table.insert(b, xy)
      end
   end
   if #b < 3 then
      return true
   end
   local p = b[1][1]
   local q = b[2][1] - b[1][1]
   local r = b[1][2]
   local s = b[2][2] - b[1][2]
   for tp = 2, #b do
      local tpair = b[tp]
      if q == 0 and tpair[1] ~= b[1][1] then
         return false
      end
      if s == 0 and tpair[2] ~= b[1][2] then
         return false
      end
      if q ~= 0 and s ~= 0 then
         local n1 = (tpair[1] - p) / q
         local n2 = (tpair[2] - r) / s
         if n1 ~= n2 then
            return false
         end
      end
   end
   return true
end

if straightline({{2, 1}, {2, 3}, {2, 5}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if straightline({{1, 4}, {3, 4}, {10, 4}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not straightline({{0, 0}, {1, 1}, {2, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if straightline({{1, 1}, {1, 1}, {1, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

