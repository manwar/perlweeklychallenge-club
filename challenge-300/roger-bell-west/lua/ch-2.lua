#! /usr/bin/lua

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function nestedarray(a)
   local arr = 0
   for i = 0, #a - 1 do
      local trail = {}
      local j = i
      while true do
         j = a[j + 1]
         if trail[j] ~= nil then
            break
         end
         trail[j] = true
      end
      arr = math.max(arr, propersize(trail))
   end
   return arr
end

if nestedarray({5, 4, 0, 3, 1, 6, 2}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if nestedarray({0, 1, 2}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

