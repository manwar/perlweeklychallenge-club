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

function countasterisks(a)
   local out = 0
   local active = true
   for _, c in ipairs(split(a)) do
      if c == '|' then
         active = not active
      end
      if c == '*' then
         if active then
            out = out + 1
         end
      end
   end
   return out
end

if countasterisks("p|*e*rl|w**e|*ekly|") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countasterisks("perl") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countasterisks("th|ewe|e**|k|l***ych|alleng|e") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

