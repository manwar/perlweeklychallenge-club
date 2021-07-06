#!/usr/bin/env lua

-- run <script> <number>

function nxt(s)
   a,b=string.match(s:reverse(),"(3*)(.*)")
   pre,threes=b:reverse(),a
   if pre:len() ~= 0 then
      return math.floor(pre+1) .. string.sub(string.rep("12",threes:len()),1,threes:len())
   end
   return string.sub(string.rep("12",s:len()),1,s:len()+1)
end

out="0"
for i=1,arg[1] do
   out=nxt(out)
end
print(out)
