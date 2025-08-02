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

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function values(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, v)
   end
   return a
end

function sum(t)
   local ss = 0
   for i, k in ipairs(t) do
      ss = ss + k
   end
   return ss
end

function strongpassword(a)
   local ctypes = {}
   local reps = 0
   local rep = 0
   local old = '@'
   local changes = {}
   for i, c in ipairs(split(a)) do
      if (i > 0 and c == old) then
         rep = rep + 1
         if rep >= 2 then
            reps = reps + 1
         end
      else
         rep = 0
         old = c
      end
      local t = 'n'
      if c >= 'A' and c <= 'Z' then
         t = 'u'
      elseif c >= 'a' and c <= 'z' then
         t = 'l'
      elseif c >= '0' and c <= '9' then
         t = 'd'
      end
      if ctypes[t] == nil then
         ctypes[t] = 0
      end
      ctypes[t] = ctypes[t] + 1
   end
   table.insert(changes, reps)
   ctypes['n'] = nil
   local k = #keys(ctypes)
   if (k < 3) then
      local spare = sum(values(ctypes)) - k
      if spare < 0 then
         table.insert(changes, -spare)
      end
   end
   if (string.len(a) < 6) then
      table.insert(changes, 6 - string.len(a))
   end
   return math.max(table.unpack(changes))
end

if strongpassword("a") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if strongpassword("aB2") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if strongpassword("PaaSW0rd") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if strongpassword("Paaasw0rd") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if strongpassword("aaaaa") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

