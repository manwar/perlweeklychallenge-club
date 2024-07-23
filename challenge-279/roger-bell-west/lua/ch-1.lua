#! /usr/bin/lua

function join(t)
   local out=""
   for i, v in ipairs(t) do
      out = out .. v
   end
   return out
end

function sortletters(a, n)
   local out = {}
   for _a, _b in ipairs(a) do
      table.insert(out, "")
   end
   for i, l in ipairs(a) do
      out[n[i]] = l
   end
   return join(out)
end

if sortletters({"R", "E", "P", "L"}, {3, 2, 1, 4}) == "PERL" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortletters({"A", "U", "R", "K"}, {2, 4, 1, 3}) == "RAKU" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if sortletters({"O", "H", "Y", "N", "P", "T"}, {5, 4, 2, 6, 1, 3}) == "PYTHON" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

