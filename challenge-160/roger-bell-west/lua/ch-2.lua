#! /usr/bin/lua

function equilibriumindex(s)
   local sm=0
   for k,v in ipairs(s) do
      sm = sm + v
   end
   local sa=0
   for k,v in ipairs(s) do
      sa = sa + v
      if sa == sm then
         return k
      end
      sa = sa + v
   end
   return 0
end

if equilibriumindex({1,3,5,7,9}) == 4 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if equilibriumindex({1,2,3,4,5}) == 0 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if equilibriumindex({2,4,2}) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
