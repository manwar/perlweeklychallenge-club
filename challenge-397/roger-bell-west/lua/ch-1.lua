#! /usr/bin/lua

function reduce(seq, func)
   local out = seq[1]
   for i = 2, #seq do
      out = func(out, seq[i])
   end
   return out
end

function toset(a)
   local cc = {}
   for _, c in ipairs(a) do
      cc[c] = true
   end
   return cc
end

function absentsmallestpositive(a)
   local tot = reduce(a, function (a, b) return a + b end)
   local ex = toset(a)
   local mul = #a
   local n = 1
   while true do
      if n * mul > tot and ex[n] == nil then
         return n
      end
      n = n + 1
   end
end

if absentsmallestpositive({1, 2, 4, 5, 6}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if absentsmallestpositive({-5, -2, -1, 3}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if absentsmallestpositive({1, 2, 3}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if absentsmallestpositive({2, 3, 7, 8}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if absentsmallestpositive({1, 1, 1, 10}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

