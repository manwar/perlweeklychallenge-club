#! /usr/bin/lua

function emptyarray(a0)
   local t = 0
   local a = a0
   while #a > 0 do
      local mn = math.min(table.unpack(a))
      for i, v in ipairs(a) do
         if v == mn then
            table.remove(a, i)
            t = t + i
            break
         end
      end
   end
   return t
end

      

if emptyarray({3, 4, 2}) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if emptyarray({1, 2, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

