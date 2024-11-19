#! /usr/bin/lua

function matchsticksquare(a)
   local perimeter = 0
   local ss = {}
   for _, v in ipairs(a) do
      perimeter = perimeter + v
      table.insert(ss, v)
   end
   if perimeter % 4 ~= 0 then
      return false
   end
   local side = perimeter // 4
   table.sort(ss, function (i, j) return j < i end)
   local sidesleft = 4
   local lengthleft = side
   while true do
      local leftover = {}
      for _, m in ipairs(ss) do
         if m > side then
            return false
         end
         if m <= lengthleft then
            lengthleft = lengthleft- m
            if lengthleft == 0 then
               sidesleft = sidesleft - 1
               lengthleft = side
            end
         else
            table.insert(leftover, m)
         end
      end
      if #leftover == 0 then
         break
      end
      ss = leftover
   end
   return sidesleft == 0 and lengthleft == side
end

if matchsticksquare({1, 2, 2, 2, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not matchsticksquare({2, 2, 2, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not matchsticksquare({2, 2, 2, 2, 4}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if matchsticksquare({3, 4, 1, 4, 3, 1}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

