#! /usr/bin/lua

function sum(t)
   local ss = 0
   for i, k in ipairs(t) do
      ss = ss + k
   end
   return ss
end

function finalscore(a)
   local p = {}
   for _, n in ipairs(a) do
      if n == "C" then
         table.remove(p, #p)
      elseif n == "D" then
         table.insert(p, 2 * p[#p])
      elseif n == "+" then
         table.insert(p, p[#p - 1] + p[#p])
      else
         table.insert(p, tonumber(n))
      end
   end
   return sum(p)
end

if finalscore({"5", "2", "C", "D", "+"}) == 30 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if finalscore({"5", "-2", "4", "C", "D", "9", "+", "+"}) == 27 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if finalscore({"7", "D", "D", "C", "+", "3"}) == 45 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if finalscore({"-5", "-10", "+", "D", "C", "+"}) == -55 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if finalscore({"3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"}) == 128 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

