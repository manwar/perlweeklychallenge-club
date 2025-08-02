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

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function friendlystrings(a, b)
   local aa = split(a)
   for i = 1, #aa - 1 do
      for j = i + 1, #aa do
         local cc = deepcopy(aa)
         cc[i] = aa[j]
         cc[j] = aa[i]
         if join(cc) == b then
            return true
         end
      end
   end
   return false
end

if friendlystrings("desc", "dsec") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if friendlystrings("fuck", "fcuk") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not friendlystrings("poo", "eop") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if friendlystrings("stripe", "sprite") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

