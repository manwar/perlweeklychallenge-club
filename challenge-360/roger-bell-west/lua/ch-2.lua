#! /usr/bin/lua
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

function splits(inputstr, sep)
   sep = sep or '%s'
   local starts = {1}
   local ends = {}
   local n = 1
   while true do
      local fs, fe = string.find(inputstr, sep, n)
      if fs == nil then
         break
      end
      table.insert(ends, fs - 1)
      table.insert(starts, fe + 1)
      n = fe + 1
   end
   table.insert(ends, #inputstr)
   local t = {}
   for i = 1, #starts do
      local s = starts[i]
      local e = ends[i]
      if e >= s then
         table.insert(t, string.sub(inputstr, s, e))
      end
   end
   return t
end

function joins(t, pad)
   local out = ""
   local later = false
   for k,v in pairs(t) do
      if later then
         out = out .. pad
      end
      out = out .. v
      later = true
   end
   return out
end

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function wordsorter(a)
   local w = splits(a, " ")
   local wl = map(w, string.lower)
   local i = {}
   for j = 1, #w do
      table.insert(i, j)
   end
   table.sort(i,
              function(aa, bb) return wl[aa] < wl[bb] end)
   w = map(i, function(x) return w[x] end)
   return joins(w, " ")
end

if wordsorter("The quick brown fox") == "brown fox quick The" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordsorter("Hello    World!   How   are you?") == "are Hello How World! you?" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordsorter("Hello") == "Hello" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordsorter("Hello, World! How are you?") == "are Hello, How World! you?" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordsorter("I have 2 apples and 3 bananas!") == "2 3 and apples bananas! have I" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

