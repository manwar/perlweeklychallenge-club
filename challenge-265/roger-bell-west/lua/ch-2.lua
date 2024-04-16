#! /usr/bin/lua

function str2hash(a)
   local m = {}
   for c in string.gmatch(a, "%a") do
      local lc = string.lower(c)
      if m[lc] == nil then
         m[lc] = 1
      else
         m[lc] = m[lc] + 1
      end
   end
   return m
end

function completingword(a, cw)
   local ah = str2hash(a)
   local out = {}
   for _, t in ipairs(cw) do
      local valid = true
      local th = str2hash(t)
      for k, v in pairs(ah) do
         if th[k] == nil then
            valid = false
            break
         end
         if th[k] < v then
            valid = false
            break
         end
      end
      if valid then
         table.insert(out, t)
      end
   end
   if #out == 0 then
      return ""
   end
   table.sort(out, function (i, j) return string.len(i) < string.len(j) end)
   return out[1]
end

if completingword("aBc 11c", {"accbbb", "abc", "abbc"}) == "accbbb" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if completingword("La1 abc", {"abcl", "baacl", "abaalc"}) == "baacl" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if completingword("JB 007", {"jj", "bb", "bjb"}) == "bjb" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

