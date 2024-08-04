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

function twiceappearance(a)
   local m = {}
   for _, c in ipairs(split(a)) do
      if m[c] ~= nil then
         return c
      end
      m[c] = true
   end
   return 'x'
end

if twiceappearance("acbddbca") == "d" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if twiceappearance("abccd") == "c" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if twiceappearance("abcdabbb") == "a" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

