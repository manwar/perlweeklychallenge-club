#! /usr/bin/lua

function greatestenglishletter(a)
   local m = {}
   for c in string.gmatch(a, ".") do
      local uc = string.upper(c)
      local flag = 2
      if uc == c then
         flag = 1
      end
      if m[uc] ~= nil then
         flag = flag | m[uc]
      end
      m[uc] = flag
   end
   local m2 = {}
   for k, v in pairs(m) do
      if v == 3 then
         table.insert(m2, k)
      end
   end
   if #m2 > 0 then
      table.sort(m2)
      return m2[#m2]
   else
      return ""
   end
end

if greatestenglishletter("PeRlwEeKLy") == "L" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if greatestenglishletter("ChaLlenge") == "L" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if greatestenglishletter("The") == "" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

