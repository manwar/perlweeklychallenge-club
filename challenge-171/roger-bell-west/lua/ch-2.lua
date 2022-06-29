#! /usr/bin/lua

local f = function(x)
   return x + 1
end

local g = function(x)
   return x * 2
end

function compose (f1, f2)
   return function(x)
      return f1(f2(x))
   end
end

local h = compose(f, g)

for i = 1,10 do
   if f(g(i)) == h(i) then
      io.write("Pass")
   else
      io.write("FAIL")
   end
   io.write(" ")
end
print("")

