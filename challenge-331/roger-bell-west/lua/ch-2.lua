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

function buddystrings(a, b)
   for i = 1, #a - 1 do
      for j = i + 1, #a do
         local acx = split(a)
         acx[i], acx[j] = acx[j], acx[i]
         if join(acx) == b then
            return true
         end
      end
   end
   return false
end

if buddystrings("fuck", "fcuk") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not buddystrings("love", "love") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if buddystrings("fodo", "food") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if buddystrings("feed", "feed") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

