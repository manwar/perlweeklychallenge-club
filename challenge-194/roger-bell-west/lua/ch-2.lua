#! /usr/bin/lua

function frequencyequalizer(s)
   local f = {}
   for c in string.gmatch(s, ".") do
      if f[c] == nil then
         f[c] = 1
      else
         f[c] = f[c] + 1
      end
   end
   local sk = {}
   for i, v in pairs(f) do
      table.insert(sk, v)
   end
   table.sort(sk)
   if sk[1] == sk[#sk-1] and
      sk[1] + 1 == sk[#sk] then
      return true
   end
   return false
end

if frequencyequalizer("abbc") == true then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if frequencyequalizer("xyzyyxz") == true then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if frequencyequalizer("xzxz") == false then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
