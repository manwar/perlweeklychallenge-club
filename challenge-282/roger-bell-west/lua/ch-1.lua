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

function goodinteger(a)
   local winsize = 3
   local d = split(a)
   for offset = 1, #d - winsize + 1 do
      local cc = {d[offset], d[offset + 1], d[offset + 2]}
      if cc[1] == cc[2] and cc[2] == cc[3] then
         if (offset == 1 or d[offset - 1] ~= cc[1]) and
            (offset == #d - winsize + 1 or d[offset + winsize] ~= cc[3]) then
            return join(cc) + 0
         end
      end
   end
   return -1
end

if goodinteger(12344456) == 444 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodinteger(1233334) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodinteger(10020003) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

