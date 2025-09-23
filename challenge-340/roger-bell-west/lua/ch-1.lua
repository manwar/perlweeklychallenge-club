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

function join(t)
   local out=""
   for i, v in ipairs(t) do
      out = out .. v
   end
   return out
end

function duplicateremovals(a)
   local b = {}
   for _, c in ipairs(split(a)) do
      if #b == 0 or c ~= b[#b] then
         table.insert(b, c)
      else
         table.remove(b, #b)
      end
   end
   return join(b)
end

if duplicateremovals("abbaca") == "ca" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if duplicateremovals("azxxzy") == "ay" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if duplicateremovals("aaaaaaaa") == "" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if duplicateremovals("aabccba") == "a" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if duplicateremovals("abcddcba") == "" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

