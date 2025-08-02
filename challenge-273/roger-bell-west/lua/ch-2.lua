#! /usr/bin/lua

function baftera(a)
   local firstb = string.find(a, "b")
   local lasta = string.find(string.reverse(a), "a")
   if firstb == nil then
      return false
   end
   if lasta == nil then
      return true
   end
   lasta = string.len(a) + 1 - lasta
   return lasta < firstb
end

if baftera("aabb") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not baftera("abab") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not baftera("aaa") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if baftera("bbb") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

