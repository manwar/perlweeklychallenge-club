#! /usr/bin/lua

function productsign(a)
   local out = 1
   for _, t in ipairs(a) do
      if t < 0 then
         out = - out
      elseif t == 0 then
         out = 0
         break
      end
   end
   return out
end

if productsign({-1, -2, -3, -4, 3, 2, 1}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if productsign({1, 2, 0, -2, -1}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if productsign({-1, -1, 1, -1, 2}) == -1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

