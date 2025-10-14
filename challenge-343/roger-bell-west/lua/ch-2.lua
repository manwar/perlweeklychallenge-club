#! /usr/bin/lua

function reduce(seq, func)
   local out = seq[1]
   for i = 2, #seq do
      out = func(out, seq[i])
   end
   return out
end

function championteam(a)
   local maxw = 0
   local teamw = {}
   for i, w in ipairs(a) do
      local wins = reduce(w, function(a, b) return a + b end)
      if wins > maxw then
         teamw = {}
         maxw = wins
      end
      if wins == maxw then
         table.insert(teamw, i)
      end
   end
   if #teamw == 1 then
      return teamw[1] - 1
   end
   local bestt = teamw[1]
   for _, rt in ipairs(teamw) do
      if a[rt][bestt] == 1 then
         bestt = rt
      end
   end
   return bestt - 1
end


if championteam({{0, 1, 1}, {0, 0, 1}, {0, 0, 0}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if championteam({{0, 1, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}, {1, 1, 1, 0}}) == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if championteam({{0, 1, 0, 1}, {0, 0, 1, 1}, {1, 0, 0, 0}, {0, 0, 1, 0}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if championteam({{0, 1, 1}, {0, 0, 0}, {0, 1, 0}}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if championteam({{0, 0, 0, 0, 0}, {1, 0, 0, 0, 0}, {1, 1, 0, 1, 1}, {1, 1, 0, 0, 0}, {1, 1, 0, 1, 0}}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

