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

function circular(a)
   local aa = {}
   for _, s in ipairs(a) do
      table.insert(aa, split(s))
   end
   for pi = 1, #aa - 1 do
      if aa[pi][#aa[pi]] ~= aa[pi + 1][1] then
         return false
      end
   end
   return true
end

if circular({"perl", "loves", "scala"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not circular({"love", "the", "programming"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if circular({"java", "awk", "kotlin", "node.js"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

