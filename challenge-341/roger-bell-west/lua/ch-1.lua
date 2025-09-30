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

function brokenkeyboard(a, b)
   local bk = {}
   for _, c in ipairs(b) do
      bk[string.lower(c)] = true
   end
   local ct = 0
   for _, w in ipairs(splits(string.lower(a), " ")) do
      local valid = true
      for __, c in ipairs(split(w)) do
         if bk[c] ~= nil then
            valid = false
            break
         end
      end
      if valid then
         ct = ct + 1
      end
   end
   return ct
end

if brokenkeyboard("Hello World", {"d"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeyboard("apple banana cherry", {"a", "e"}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeyboard("Coding is fun", {}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeyboard("The Weekly Challenge", {"a", "b"}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if brokenkeyboard("Perl and Python", {"p"}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

