#! /usr/bin/lua

function smallestindex(a)
   for i, n in ipairs(a) do
      local j = i - 1;
      if n % 10 == j then
         return j
      end
   end
   return -1
end

if smallestindex({0, 1, 2}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if smallestindex({4, 3, 2, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if smallestindex({1, 2, 3, 4, 5, 6, 7, 8, 9, 0}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

