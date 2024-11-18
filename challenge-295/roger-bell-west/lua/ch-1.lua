#! /usr/bin/lua

function wordbreak(a, words)
   local queue = {a}
   while #queue > 0 do
      local remnant = table.remove(queue, 1)
      if #remnant == 0 then
         return true
      end
      for _, candidate in ipairs(words) do
         if string.find(remnant, candidate) == 1 then
            table.insert(queue, string.sub(remnant, #candidate + 1))
         end
      end
   end
   return false
end

if wordbreak("weeklychallenge", {"challenge", "weekly"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordbreak("perlrakuperl", {"raku", "perl"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not wordbreak("sonsanddaughters", {"sons", "sand", "daughters"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

