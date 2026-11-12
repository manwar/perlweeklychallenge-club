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

function sum(t)
   local ss = 0
   for i, k in ipairs(t) do
      ss = ss + k
   end
   return ss
end

function longestabsolutepath(fs)
   local components = {}
   local maxlen = 0
   for _, entry0 in ipairs(splits(fs, "\n")) do
      local entry = entry0
      local depth = 0
      while string.match(entry, "^\t") ~= nil do
         entry = string.sub(entry, 2)
         depth = depth + 1
         end
      local parts = splits(entry, "\t")
      while #components < depth do
         table.insert(components, 0)
      end
      while #components > depth do
         table.remove(components, #components)
      end
      table.insert(components, #entry)
      if string.match(entry, "[.]") then
         maxlen = math.max(
            maxlen,
            sum(components) + #components - 1
         )
      end
   end
   return maxlen
end


if longestabsolutepath("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestabsolutepath("file1.txt\nfile2.ext\na.png") == 9 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestabsolutepath("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png") == 38 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestabsolutepath("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt") == 14 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if longestabsolutepath("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt") == 32 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

