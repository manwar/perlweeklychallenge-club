#! /usr/bin/lua

function countevendigitsnumber(a)
   local t = 0
   for _, p in ipairs(a) do
      local even = false
      local pt = p
      while pt >= 10 do
         pt = math.floor(pt / 10)
         even = not even
      end
      if even then
         t = t + 1
      end
   end
   return t
end

if countevendigitsnumber({10, 1, 111, 24, 1000}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countevendigitsnumber({111, 1, 11111}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if countevendigitsnumber({2, 8, 1024, 256}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

