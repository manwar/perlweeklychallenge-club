#! /usr/bin/lua

-- by hookenz at
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function exdigits(digits, st, ed)
   local x = 0
   for i = st, ed do
      x = x * 10 + digits[i]
   end
   return x
end

function additivenumber(digitstring)
   local digits = {}
   for c in string.gmatch(string.lower(digitstring), "%d") do
      table.insert(digits, tonumber(c))
   end
   local stack = {}
   for i = 1, #digits - 2 do
      for j = i + 1, #digits - 1 do
         table.insert(stack, {1, i, j})
      end
   end
   while #stack > 0 do
      local t = table.remove(stack, #stack)
      local start_a = t[1]
      local end_a = t[2]
      local end_b = t[3]
      local start_b = end_a + 1
      local val_ab = exdigits(digits, start_a, end_a) +
         exdigits(digits, start_b, end_b)
      local start_c = end_b + 1
      for end_c = start_c, #digits do
         if val_ab == exdigits(digits, start_c, end_c) then
            if end_c == #digits then
               return true
            else
               table.insert(stack, {start_b, end_b, end_c})
               break
            end
         end
      end
   end
   return false
end

if additivenumber("112358") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not additivenumber("12345") then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if additivenumber("199100199") then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

