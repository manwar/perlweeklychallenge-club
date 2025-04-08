#! /usr/bin/lua

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function subsequence(a, b)
   local l = a
   local s = b
   if #a < #b then
      l = b
      s = a
   end
   local st = split(s)
   local si = 1
   for _, c in ipairs(split(l)) do
      if c == st[si] then
         si = si + 1
         if si > #st then
            return true
         end
      end
   end
   return false
end

if subsequence("uvw", "bcudvew") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not subsequence("aec", "abcde") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if subsequence("sip", "javascript") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

