#! /usr/bin/lua

function damm(n)
   local tab = {
    {0,3,1,7,5,9,8,6,4,2},
    {7,0,9,2,1,5,4,8,6,3},
    {4,2,0,6,8,7,1,3,5,9},
    {1,7,5,0,9,8,3,4,2,6},
    {6,1,2,3,0,4,5,9,7,8},
    {3,6,7,4,2,0,9,5,8,1},
    {5,8,6,9,7,2,0,1,3,4},
    {8,9,4,5,3,6,2,0,1,7},
    {9,4,3,8,6,1,7,2,0,5},
    {2,5,8,1,4,3,6,7,9,0}
   }
   local digits = {}
   string.gsub(tostring(n), ".", function(c) table.insert(digits,c) end)
   local c = 0
   for i,dd in ipairs(digits) do
      c = tab[c+1][tonumber(dd)+1]
   end
   return c
end

function checkdamm(n)
   return damm(n) == 0
end

if checkdamm(5724) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not checkdamm(5727) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
