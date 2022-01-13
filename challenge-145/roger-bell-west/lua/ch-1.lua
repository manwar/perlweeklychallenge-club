#! /usr/bin/lua

function dotproduct(a,b)
   p=0
   for k1,v1 in pairs(a) do
      p = p + v1 * b[k1]
  end
  return p
end

if (dotproduct({1,2,3},{4,5,6}) == 32) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")
