#! /usr/bin/lua

function taxamount(income, brackets)
   local tax = 0
   local lastbracket = 0
   for _, bracket in ipairs(brackets) do
      if income > lastbracket then
         tax = tax + (math.min(income, bracket[1]) - lastbracket) * bracket[2]
      else
         break
      end
      lastbracket = bracket[1]
   end
   return tax / 100
end

if taxamount(10, {{3, 50}, {7, 10}, {12, 25}}) == 2.65 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if taxamount(2, {{1, 0}, {4, 25}, {5, 50}}) == 0.25 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if taxamount(0, {{2, 50}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

