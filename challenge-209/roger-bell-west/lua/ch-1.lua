#! /usr/bin/lua

function specialbitcharacters(a)
   local s = 0
   for k, v in ipairs(a) do
      if s == 1 then
         s = 2
      else
         s = v
      end
   end
   return s == 0
end

if specialbitcharacters({1, 0, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not specialbitcharacters({1, 1, 1, 0}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

