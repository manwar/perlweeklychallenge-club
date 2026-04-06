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

function parsetime(a)
   local p = splits(a, ":")
   return p[1] * 60 + p[2]
end

function conflictevents(a, b)
   local r = {}
   for _, t in ipairs({a, b}) do
      local st = parsetime(t[1])
      local en = parsetime(t[2])
      if st < en then
         table.insert(r, {{st, en - 1}})
      else
         table.insert(r, {
                         {st, 1440 - 1},
                         {0, en - 1},
         })
      end
   end
   for _a, ra in ipairs(r[1]) do
      for _b, rb in ipairs(r[2]) do
         if ra[1] <= rb[2] and rb[1] <= ra[2] then
            return true
         end
      end
   end
   return false   
end
   
if conflictevents({"10:00", "12:00"}, {"11:00", "13:00"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not conflictevents({"09:00", "10:30"}, {"10:30", "12:00"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if conflictevents({"14:00", "15:30"}, {"14:30", "16:00"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not conflictevents({"08:00", "09:00"}, {"09:01", "10:00"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if conflictevents({"23:30", "00:30"}, {"00:00", "01:00"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

