#! /usr/bin/lua

function r2qi(n)
   return c2qi(n, 0)
end

function c2qi(r0, i0)
   local l = {}
   for i, n0 in pairs({i0, r0}) do
      local n = n0
      local digits = {}
      while n ~= 0 do
         local digit = n % -4
         n = n // -4
         if digit < 0 then
            digit = digit + 4
            n = n + 1
         end
         table.insert(digits,digit)
      end
      table.insert(l,digits)
   end
   local ld = #(l[1]) - #(l[2])
   if ld < 0 then
      for i = 1,(-ld-1) do
         table.insert(l[1],1,0)
      end
   elseif ld > 1 then
      for i = 1,ld do
         table.insert(l[2],1,0)
      end
   end
   o = ""
   for i = #(l[2]),1,-1 do
      for b = 1,2 do
         if #(l[b]) >= i then
            o = o .. tostring(l[b][i])
         end
      end
   end
   return o
end

function qi2r(n)
   return qi2c(n)[1]
end

function qi2c(n)
   local pow = 1
   local ri = 1
   local o = { 0, 0 }
   for ch in string.gmatch(string.reverse(n), "(.)") do
      o[ri] = o[ri] + tonumber(ch) * pow
      ri = ri + 1
      pow = pow * 2
      if ri == 3 then
         ri = 1
         pow = -pow
      end
   end
   return o
end

if r2qi(4) == "10300" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if qi2r("10300") == 4 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
