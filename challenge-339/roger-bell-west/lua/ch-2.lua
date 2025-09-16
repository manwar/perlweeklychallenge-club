#! /usr/bin/lua

function peakpoint(a)
   local h = 0
   local o = 0
   for _, p in ipairs(a) do
      h = h + p
      o = math.max(o, h)
   end
   return o
end

if peakpoint({-5, 1, 5, -9, 2}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if peakpoint({10, 10, 10, -25}) == 30 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if peakpoint({3, -4, 2, 5, -6, 1}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if peakpoint({-1, -2, -3, -4}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if peakpoint({-10, 15, 5}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

