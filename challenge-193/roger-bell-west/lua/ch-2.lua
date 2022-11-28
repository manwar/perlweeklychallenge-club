#! /usr/bin/lua

function oddstring(ss)
   for i = 1,#(ss[1])-1 do
      local tab = {}
      for p,s in ipairs(ss) do
         local v = string.byte(s, i+1) - string.byte(s, i)
         if tab[v] == nil then
            tab[v] = { s }
         else
            table.insert(tab[v], s)
         end
      end
      for i,j in pairs(tab) do
         if #j == 1 then
            return j[1]
         end
      end
   end
   return ""
end

if oddstring({"adc", "wzy", "abc"}) == "abc" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if oddstring({"aaa", "bob", "ccc", "ddd"}) == "bob" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
