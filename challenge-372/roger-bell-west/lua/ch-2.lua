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

function largestsubstring(a)
   local cc = split(a)
   for offset = #cc - 1, 1, -1 do
      for x = 1, #cc - offset do
         if cc[x] == cc[x + offset] then
            return offset - 1
         end
      end
   end
   return -1
end

if largestsubstring("aaaaa") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if largestsubstring("abcdeba") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if largestsubstring("abbc") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if largestsubstring("abcaacbc") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if largestsubstring("laptop") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

