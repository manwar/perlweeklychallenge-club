#! /usr/bin/lua

function oddmatrix(rows, cols, points)
   local rm = {}
   local cm = {}
   for _, p in ipairs(points) do
      if rm[p[1]] == nil then
         rm[p[1]] = true
      else
         rm[p[1]] = nil
      end
      if cm[p[2]] == nil then
         cm[p[2]] = true
      else
         cm[p[2]] = nil
      end
   end
   local cml = length(cm)
   local rml = length(rm)
   return rml * (cols - cml) + cml * (rows -rml)
end

function length(t)
   local l = 0
   for k, v in pairs(t) do
      l = l + 1
   end
   return l
end

if oddmatrix(2, 3, {{0, 1}, {1, 1}}) == 6 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddmatrix(2, 2, {{1, 1}, {0, 0}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddmatrix(3, 3, {{0, 0}, {1, 2}, {2, 1}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddmatrix(1, 5, {{0, 2}, {0, 4}}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if oddmatrix(4, 2, {{1, 0}, {3, 1}, {2, 0}, {0, 1}}) == 8 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

