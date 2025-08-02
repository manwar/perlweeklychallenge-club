#! /usr/bin/lua

function closestpalindrome(a)
   local delta = -1
   while true do
      q = string.format("%d", a + delta)
      if q == string.reverse(q) then
         return q
      end
      delta = -delta
      if delta < 0 then
         delta = delta - 1
      end
   end
end

if closestpalindrome("123") == "121" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if closestpalindrome("2") == "1" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if closestpalindrome("1400") == "1441" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if closestpalindrome("1000") == "999" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

