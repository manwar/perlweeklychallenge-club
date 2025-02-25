#! /usr/bin/lua

function semiorderedpermutation(a)
   local en = #a
   local s = 1
   local e = en
   for i, n in ipairs(a) do
      if n == 1 then
         s = i
      end
      if n == en then
         e = i
      end
   end
   local r = s - 1 + (en - e)
   if s > e then
      r = r - 1
   end
   return r
end

if semiorderedpermutation({2, 1, 4, 3}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if semiorderedpermutation({2, 4, 1, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if semiorderedpermutation({1, 3, 2, 4, 5}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

