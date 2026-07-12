#! /usr/bin/lua

function samerowcolumn(a)
   for _i, row in ipairs(a) do
      local notfound = {}
      for i = 1, #row do
         notfound[i] = true
      end
      for _j, n in ipairs(row) do
         notfound[n] = nil
      end
      for k, v in pairs(notfound) do
         return false
      end
   end
   for coln = 1, #a[1] do
      local notfound = {}
      for i = 1, #a do
         notfound[i] = true
      end
      for _i, row in ipairs(a) do
         notfound[row[coln]] = nil
      end
      for k, v in pairs(notfound) do
         return false
      end
   end
   return true
end

if samerowcolumn({{1, 2, 3, 4}, {2, 3, 4, 1}, {3, 4, 1, 2}, {4, 1, 2, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if samerowcolumn({{1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not samerowcolumn({{1, 2, 5}, {5, 1, 2}, {2, 5, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not samerowcolumn({{1, 2, 3}, {1, 2, 3}, {1, 2, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not samerowcolumn({{1, 2, 3}, {3, 1, 2}, {3, 2, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

