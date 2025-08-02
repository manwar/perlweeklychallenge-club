#! /usr/bin/lua

function maxpositivenumber(a)
   local pos = 0
   local neg = 0
   for _, c in ipairs(a) do
      if c > 0 then
         pos = pos + 1
      elseif c < 0 then
         neg = neg + 1
      end
   end
   return math.max(pos, neg)
end

if maxpositivenumber({-3, 1, 2, -1, 3, -2, 4}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxpositivenumber({-1, -2, -3, 1}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxpositivenumber({1, 2}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

