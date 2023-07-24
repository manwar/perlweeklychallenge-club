#! /usr/bin/lua


function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function zeroarray(a)
   local s = {}
   for i, v in ipairs(a) do
      s[v] = 1
   end
   s[0] = nil
   return propersize(s)
end

if zeroarray({1, 5, 0, 3, 5}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zeroarray({0}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if zeroarray({2, 1, 4, 0, 3}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

