#! /usr/bin/lua

function killandwin(a)
   local t = 0
   for k, v in ipairs(a) do
      t = t + v
   end
   return t
end

if killandwin({2, 3, 1}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if killandwin({1, 1, 2, 2, 2, 3}) == 11 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

