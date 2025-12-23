#! /usr/bin/lua

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

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

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



function maxwords(a)
   return math.max(table.unpack(map(a, function (x) return #(splits(x, " ")) end)))
end

if maxwords({"Hello world", "This is a test", "Perl is great"}) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxwords({"Single"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxwords({"Short", "This sentence has six words in total", "A B C", "Just four words here"}) == 7 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxwords({"One", "Two parts", "Three part phrase", ""}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maxwords({"The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"}) == 10 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

