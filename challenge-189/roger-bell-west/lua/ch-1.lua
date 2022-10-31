#! /usr/bin/lua

function greatercharacter(a, k)
   local aa = {}
   for dummy, x in ipairs(a) do
      if x > k then
         table.insert(aa, x)
      end
   end
   table.sort(aa)
   if #aa > 0 then
      return aa[1]
   else
      return k
   end
end

if greatercharacter({"e", "m", "u", "g"}, "b") == "e" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if greatercharacter({"d", "c", "e", "f"}, "a") == "c" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if greatercharacter({"j", "a", "r"}, "o") == "r" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if greatercharacter({"d", "c", "a", "f"}, "a") == "c" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if greatercharacter({"t", "g", "a", "l"}, "v") == "v" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
