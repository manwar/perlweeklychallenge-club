#! /usr/bin/lua

function tsp(tree)
   mp=0
   for k1,v1 in pairs(tree) do
      mr=v1[1]
      for k2,v2 in pairs(v1) do
         mr=math.min(mr,v2)
      end
      mp = mp + mr
   end
   return mp
end

if tsp({{1},{5,3},{2,3,4},{7,1,0,2},{6,4,5,2,8}}) == 8 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if tsp({{5},{2,3},{4,1,4},{0,1,2,3},{7,2,4,1,9}}) == 9 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
