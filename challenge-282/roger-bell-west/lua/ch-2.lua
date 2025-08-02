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

function changingkeys(a)
   local oc = "x"
   local out = 0
   for i, c in ipairs(split(string.lower(a))) do
      if i == 1 then
         oc = c
      elseif c ~= oc then
         oc = c
         out = out + 1
      end
   end
   return out
end

if changingkeys("pPeERrLl") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if changingkeys("rRr") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if changingkeys("GoO") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

