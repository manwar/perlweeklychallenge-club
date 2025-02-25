#! /usr/bin/lua

function toset(a)
   local p = {}
   for _, c in ipairs(a) do
      p[c] = true
   end
   return p
end

function countcommon(a, b)
   local aa = toset(a)
   local bb = toset(b)
   local out = 0
   for c, _ in pairs(aa) do
      if bb[c] ~= nil then
         out = out + 1
      end
   end
   return out
end

if countcommon({"perl", "weekly", "challenge"}, {"raku", "weekly", "challenge"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countcommon({"perl", "raku", "python"}, {"python", "java"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countcommon({"guest", "contribution"}, {"fun", "weekly", "challenge"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

