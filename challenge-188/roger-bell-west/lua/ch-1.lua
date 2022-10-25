#! /usr/bin/lua

function divisiblepairs(a, k)
   local ct = 0
   for ai = 1,#a-1 do
      for bi = ai+1,#a do
         if (a[ai] + a[bi]) % k == 0 then
            ct = ct + 1
         end
      end
   end
   return ct
end

if (divisiblepairs({4, 5, 1, 6}, 2) == 2) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (divisiblepairs({1, 2, 3, 4}, 2) == 2) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (divisiblepairs({1, 3, 4, 5}, 3) == 2) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (divisiblepairs({5, 1, 2, 3}, 4) == 2) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if (divisiblepairs({7, 2, 4, 5}, 4) == 1) then
   io.write("Pass")
else
   io.write("FAIL")
end

print("")
