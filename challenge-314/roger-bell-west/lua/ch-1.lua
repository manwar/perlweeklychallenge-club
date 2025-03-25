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

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function equalstrings(a)
   local ax = {}
   for _, x in ipairs(a) do
      ax[x] = true
   end
   local ca = {}
   for _, x in ipairs(keys(ax)) do
      table.insert(ca, split(x))
   end
   local mmlen = -1
   for _, x in ipairs(ca) do
      if mmlen == -1 or #x < mmlen then
         mmlen = #x
      end
   end
   local si = 0
   for i = 1, mmlen do
      si = i
      for s = 2, #ca do
         if ca[1][i] ~= ca[s][i] then
            if i == 1 then
               return -1
            end
            si = si - 1
            break
         end
      end
   end
   local ret = 0
   for _, x in ipairs(a) do
      ret = ret + #x
   end
   ret = ret - #a * si
   return ret
end

if equalstrings({"abc", "abb", "ab"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if equalstrings({"ayz", "cyz", "xyz"}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if equalstrings({"yza", "yzb", "yzc"}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

