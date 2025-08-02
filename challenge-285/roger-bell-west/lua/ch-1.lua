#! /usr/bin/lua

function noconnection(a)
   local os = {};
   local iss = {};
   for _, x in ipairs(a) do
      os[x[1]] = true
      iss[x[2]] = true
   end
   local out
   for x, _ in pairs(iss) do
      if os[x] ~= nil then
         iss[x] = nil
      else
         out = x
      end
   end
   return out
end

if noconnection({{"B", "C"}, {"D", "B"}, {"C", "A"}}) == "A" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if noconnection({{"A", "Z"}}) == "Z" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

