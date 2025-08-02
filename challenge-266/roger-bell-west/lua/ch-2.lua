#! /usr/bin/lua

function xmatrix(a)
   local order = #a + 1
   local valid = true
   for y, row in ipairs(a) do
      for x, value in ipairs(row) do
         if x == y or x == order - y then
            if value == 0 then
               valid = false
            end
         else
            if value ~= 0 then
               valid = false
            end
         end
         if not valid then
            break
         end
      end
      if not valid then
         break
      end
   end
   return valid
end

if xmatrix({{1, 0, 0, 2}, {0, 3, 4, 0}, {0, 5, 6, 0}, {7, 0, 0, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not xmatrix({{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if xmatrix({{1, 0, 2}, {0, 3, 0}, {4, 0, 5}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

