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

function groupdigitsum(a, sz)
   local s = a
   local n = 0
   while true do
      local t = ""
      for i, c in ipairs(split(s)) do
         n = n + string.byte(c) - 48
         if i == #s or (i % sz) == 0 then
            t = t .. n
            n = 0
         end
      end
      s = t
      if #s <= sz then
         break
      end
   end
   return s
end

if groupdigitsum("111122333", 3) == "359" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if groupdigitsum("1222312", 2) == "76" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if groupdigitsum("100012121001", 4) == "162" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

