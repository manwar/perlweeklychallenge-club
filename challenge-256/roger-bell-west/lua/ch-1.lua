#! /usr/bin/lua

function maximumpairs(a)
   local n = 0
   local r = {}
   for _, s in ipairs(a) do
      local t = string.reverse(s)
      if r[t] ~= nil then
         n = n + 1
      else
         r[s] = true
      end
   end
   return n
end

if maximumpairs({"ab", "de", "ed", "bc"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumpairs({"aa", "ba", "cd", "ed"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumpairs({"uv", "qp", "st", "vu", "mn", "pq"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

