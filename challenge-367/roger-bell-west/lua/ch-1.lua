#! /usr/bin/lua

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function maxoddbinary(a)
   local ones = 0
   local zeroes = 0
   for _, c in ipairs(split(a)) do
      if c == "0" then
         zeroes = zeroes + 1
      elseif c == "1" then
         ones = ones + 1
      end
   end
   if ones < 1 then
      return ""
   end
   local out = ""
   for _ = 2,ones do
      out = out .. "1"
   end
   for _ = 1,zeroes do
      out = out .. "0"
   end
   out = out .. "1"
   return out   
end

if maxoddbinary("1011") == "1101" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxoddbinary("100") == "001" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxoddbinary("111000") == "110001" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxoddbinary("0101") == "1001" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxoddbinary("1111") == "1111" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

