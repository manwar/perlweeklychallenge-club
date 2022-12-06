#! /usr/bin/lua

function digitalclock(hhmm)
   local i = string.find(hhmm, "%?")
   if i == 1 then
      if string.sub(hhmm, 2, 2) <= "3" then
         return 2
      end
      return 1
   elseif i == 2 then
      if string.sub(hhmm, 1, 1) < "2" then
         return 9
      end
      return 3
   elseif i == 4 then
      return 5
   elseif i == 5 then
      return 9
   end
   return 0
end

if digitalclock("?5:00") == 1 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if digitalclock("?3:00") == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if digitalclock("1?:00") == 9 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if digitalclock("2?:00") == 3 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if digitalclock("12:?5") == 5 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")
if digitalclock("12:5?") == 9 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
