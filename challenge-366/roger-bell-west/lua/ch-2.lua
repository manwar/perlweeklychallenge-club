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

function seq(a)
   local t = {}
   for i = 0, a do
      table.insert(t, i)
   end
   return t
end

function validtimes(a)
   local combinator = {}
   for i, c in ipairs(split(a)) do
      if string.match(c, "%d") then
         table.insert(combinator, {0 + c})
      else
         if i == 1 then
            table.insert(combinator, seq(2))
         elseif i == 2 or i == 5 then
            table.insert(combinator, seq(9))
         elseif i == 4 then
            table.insert(combinator, seq(5))
         end
      end
   end
   if #combinator ~= 4 then
      return 0
   end
   local minutes = #combinator[3] * #combinator[4]
   local ct = 0
   for ai, ax in ipairs(combinator[1]) do
      for bi, bx in ipairs(combinator[2]) do
         if ax * 10 + bx <= 23 then
            ct = ct + 1
         end
      end
   end
   return ct * minutes
end

if validtimes("?2:34") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtimes("?4:?0") == 12 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtimes("??:??") == 1440 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtimes("?3:45") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtimes("2?:15") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

