#! /usr/bin/lua

function str2tree(st)
   local o = {}
   local d = 0
   local p = 0
   for e in string.gmatch(st, "[^%s]+") do
      if e == "|" then
         d = d + 1
         p = 0
         local m = (1 << (d + 1)) - 1
         while #o < m do
            table.insert(o,0)
         end
      else
         local y=0
         if e ~= "*" then
            y=0+e
         end
         local i = (1 << d) + p
         o[i]=y
         p = p + 1
      end
   end
   return o
end

function mindepth(tree)
   firstleaf=#tree+1
   for i,e in ipairs(tree) do
      if e == 0 then
      elseif i << 1 > #tree then
         firstleaf=i
         break
      else
         ni=i << 1
         if tree[ni] == 0 and tree[ni+1]==0 then
            firstleaf=i
            break
         end
      end
   end
   d=0
   while firstleaf > 0 do
      firstleaf = firstleaf >> 1
      d = d + 1
   end
   return d
end

if mindepth(str2tree("1 | 2 3 | 4 5")) == 2 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")) == 3 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
