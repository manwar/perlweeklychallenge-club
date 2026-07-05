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

function counterify(a)
   local cc = {}
   for _, c in ipairs(a) do
      if cc[c] == nil then
         cc[c] = 0
      end
      cc[c] = cc[c] + 1
   end
   return cc
end

function values(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, v)
   end
   return a
end

function sumoffrequencies(a)
   local vw = 0
   local cn = 0
   local cc = counterify(split(a))
   local cv = values(cc)
   table.sort(cv, function (i,j) return j < i end)
   for _, n in ipairs(cv) do
      for c, ni in pairs(cc) do
         if ni == n then
            if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" then
               if vw == 0 then
                  vw = n
               end
            else
               if cn == 0 then
                  cn = n
               end
            end
         end
         if vw > 0 and cn > 0 then
            break
         end
      end
      if vw > 0 and cn > 0 then
         break
      end
   end
   return vw + cn
end

if sumoffrequencies("banana") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumoffrequencies("teestett") == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumoffrequencies("aeiouuaa") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumoffrequencies("rhythm") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sumoffrequencies("x") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

