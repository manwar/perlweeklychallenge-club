#! /usr/bin/lua

function missingnumber(l)
   local v = {}
   for dummy, i in ipairs(l) do
      v[i] = true
   end
   for i = 0,#l do
      if v[i] == nil then
         return i
      end
   end
   return 0
end

if missingnumber({0, 1, 3}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if missingnumber({0, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

