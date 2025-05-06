#! /usr/bin/lua

function maximumcount(a)
   local pos = 0
   local neg = 0
   for _, n in ipairs(a) do
      if n > 0 then
         pos = pos + 1
      elseif n < 0 then
         neg = neg + 1
      end
   end
   return math.max(pos, neg)
end

if maximumcount({-3, -2, -1, 1, 2, 3}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumcount({-2, -1, 0, 0, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumcount({1, 2, 3, 4}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

