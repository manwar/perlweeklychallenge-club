#! /usr/bin/lua

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function distinctaverage(a0)
   local a = a0
   table.sort(a,function (aa, bb) return aa < bb end)
   local offset = #a + 1
   local res = {}
   for i = 1, #a / 2 do
      res[a[i] + a[offset - i]] = true
   end
   return propersize(res)
end

if distinctaverage({1, 2, 4, 3, 5, 6}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if distinctaverage({0, 2, 4, 8, 3, 5}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if distinctaverage({7, 3, 1, 0, 5, 9}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

