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

function alphabetindexdigitsum(a, k)
   local st = ""
   for _, c in ipairs(split(a)) do
      st = st .. string.byte(c) - string.byte("a") + 1
   end
   local v = math.floor(0 + st)
   for i = 1, k do
      local j = 0
      while v > 0 do
         j = j + v % 10
         v = v // 10
      end
      v = j
   end
   return v
end   

if alphabetindexdigitsum("abc", 1) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alphabetindexdigitsum("az", 2) == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alphabetindexdigitsum("cat", 1) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alphabetindexdigitsum("dog", 2) == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alphabetindexdigitsum("perl", 3) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

