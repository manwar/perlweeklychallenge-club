#! /usr/bin/lua

function matchingmembers(a)
   local b = {}
   for _, v in ipairs(a) do
      table.insert(b, v)
   end
   table.sort(b)
   local o = 0
   for i, ae in ipairs(a) do
      if ae == b[i] then
         o = o + 1
      end
   end
   return o
end

if matchingmembers({1, 1, 4, 2, 1, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if matchingmembers({5, 1, 2, 3, 4}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if matchingmembers({1, 2, 3, 4, 5}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

