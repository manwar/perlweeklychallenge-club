#! /usr/bin/lua

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function permute(a)
   local out = {}
   local n = #a
   local c = {}
   for i = 1,n do
      table.insert(c, 1)
   end
   table.insert(out, deepcopy(a))
   local i=1
   while true do
      if i > n then
         break
      end
      if c[i] < i then
         if i % 2 == 1 then
            a[1],a[i] = a[i],a[1]
         else
            a[c[i]],a[i] = a[i],a[c[i]]
         end
         table.insert(out, deepcopy(a))
         c[i] = c[i]+1
         i = 1
      else
        c[i] = 1
         i = i+1
      end
   end
   return out
end

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

function join(t)
   local out=""
   for k,v in pairs(t) do
      out = out .. v
   end
   return out
end

function dictionaryrank(a)
   local c = split(a)
   local d = {}
   for _, o in ipairs(permute(c)) do
      d[join(o)] = true
   end
   local dd = {}
   for k, _ in pairs(d) do
      table.insert(dd, k)
   end
   table.sort(dd)
   for i, s in ipairs(dd) do
      if s == a then
         return i
      end
   end
   return 0
end

if dictionaryrank("CAT") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if dictionaryrank("GOOGLE") == 88 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if dictionaryrank("SECRET") == 255 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

