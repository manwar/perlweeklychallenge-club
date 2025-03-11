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

function ballsandboxes(a)
   local boxes = {}
   local colour = "@"
   for i, c in ipairs(split(a)) do
      if i % 2 == 1 then
         colour = c
      else
         local boxid = 0 + c
         local s = {}
         if boxes[boxid] ~= nil then
            s = boxes[boxid]
         end
         s[colour] = 1
         boxes[boxid] = s
      end
   end
   local tot = 0
   for _, v in pairs(boxes) do
      local st = 0;
      for _a, _b in pairs(v) do
         st = st + 1
         if st >= 3 then
            break
         end
      end
      if st >= 3 then
         tot = tot + 1
      end
   end
   return tot
end

if ballsandboxes("G0B1R2R0B0") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ballsandboxes("G1R3R6B3G6B1B6R1G3") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if ballsandboxes("B3B2G1B3") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

