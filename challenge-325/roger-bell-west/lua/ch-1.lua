#! /usr/bin/lua

function values(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, v)
   end
   return a
end

function consecutiveone(a)
   local h = {}
   h[0] = 0
   local latch = 0
   local latched = false
   for i, n in ipairs(a) do
      if n == 1 and not latched then
         latched = true
         latch = i
      end
      if n == 0 and latched then
         latched = false
         h[latch] = i - latch
      end
   end
   if latched then
      h[latch] = #a + 1 - latch
   end
   local tt = values(h)
   table.sort(tt)
   return tt[#tt]
end

if consecutiveone({0, 1, 1, 0, 1, 1, 1}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consecutiveone({0, 0, 0, 0}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if consecutiveone({1, 0, 1, 0, 1, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

