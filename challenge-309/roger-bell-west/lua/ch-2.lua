#! /usr/bin/lua

function mindiff(a)
   local md = 0
   local n = false
   for i = 1, #a - 1 do
      for j = i + 1, #a do
         local diff = math.abs(a[i] - a[j])
         if diff < md or n == false then
            md = diff
            n = true
         end
      end
   end
   return md
end

if mindiff({1, 5, 8, 9}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if mindiff({9, 4, 1, 7}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

