#! /usr/bin/lua

function linearrecurrencesecondorder(seq)
      local a = {seq[1], seq[2], seq[3]}
      local b = {seq[2], seq[3], seq[4]}
      local c = {seq[3], seq[4], seq[5]}
      local q = math.floor((b[3] * a[1] - b[1] * a[3]) / (b[2] * a[1] - b[1] * a[2]));
      local p = math.floor((a[3] - a[2] * q) / a[1]);
      return p * a[1] + q * a[2] == a[3] and p * b[1] + q * b[2] == b[3] and p * c[1] + q * c[2] == c[3]
end

if linearrecurrencesecondorder({1, 1, 2, 3, 5}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not linearrecurrencesecondorder({4, 2, 4, 5, 7}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if linearrecurrencesecondorder({4, 1, 2, -3, 8}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

