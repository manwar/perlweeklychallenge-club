#! /usr/bin/lua

function luhnalgorithm(a)
   local digits = {}
   string.gsub(a,
               "(.)",
               function(c)
                  if c >= "0" and c <= "9" then
                     table.insert(digits, 1, tonumber(c))
                  end
               end
   )
   local payload = table.remove(digits, 1)
   for i = 1, #digits, 2 do
      digits[i] = digits[i] * 2
      if digits[i] > 9 then
         digits[i] =digits[i] - 9
      end
   end
   local s = 0
   for i, c in ipairs(digits) do
      s = s + c
   end
   return 10 - (s % 10) == payload
end

if luhnalgorithm("17893729974") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if luhnalgorithm("4137 8947 1175 5904") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not luhnalgorithm("4137 8974 1175 5904") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

