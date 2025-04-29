#! /usr/bin/lua

function listtoset(a)
   local s = {}
   for _, x in ipairs(a) do
      s[x] = true
   end
   return s
end

function minimumcommon(a, b)
   local aa = listtoset(a)
   local cc = {}
   for _, bx in ipairs(b) do
      if aa[bx] ~= nil then
         table.insert(cc, bx)
      end
   end
   if #cc == 0 then
      return -1
   else
      return math.min(table.unpack(cc))
   end
end

if minimumcommon({1, 2, 3, 4}, {3, 4, 5, 6}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if minimumcommon({1, 2, 3}, {2, 4}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if minimumcommon({1, 2, 3, 4}, {5, 6, 7, 8}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

