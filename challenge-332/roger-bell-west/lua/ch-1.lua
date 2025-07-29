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

function joins(t,pad)
   local out=""
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

function tobinary(n)
   if n == 0 then
      return "0"
   end
   local t = {}
   local m = 0 + n
   while m > 0 do
      if (m & 1) > 0 then
         table.insert(t, 1, "1")
      else
         table.insert(t, 1, "0")
      end
      m = m >> 1
   end
   return joins(t, "")
end

function binarydate(a)
   local out = {}
   for _, n in ipairs(splits(a, "-")) do
      table.insert(out, tobinary(n))
   end
   return joins(out, "-")
end

if binarydate("2025-07-26") == "11111101001-111-11010" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if binarydate("2000-02-02") == "11111010000-10-10" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if binarydate("2024-12-31") == "11111101000-1100-11111" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

