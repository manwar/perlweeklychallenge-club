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

function powerstring(a)
   local mx = 0
   local prev = "A"
   local cur = 0
   for _, c in ipairs(split(a)) do
      if cur > 0 and c == prev then
         cur = cur + 1
      else
         cur = 1
         prev = c
      end
      mx = math.max(mx, cur)
   end
   return mx
end

if powerstring("textbook") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if powerstring("aaaaa") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if powerstring("hoorayyy") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if powerstring("x") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if powerstring("aabcccddeeffffghijjk") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

