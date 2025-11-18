#! /usr/bin/lua

function hm2m(a)
   local h, m = string.match(a, "^(%d+):(%d+)$")
   return h * 60 + m
end

function converttime(ssrc, ttgt)
   local src = hm2m(ssrc)
   local tgt = hm2m(ttgt)
   if tgt < src then
      tgt = tgt + 24 * 60
   end
   local delta = tgt - src
   local oc = 0
   for _, op in ipairs({60, 15, 5, 1}) do
      oc = oc + delta // op
      delta = delta % op
   end
   return oc
end

if converttime("02:30", "02:45") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if converttime("11:55", "12:15") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if converttime("09:00", "13:00") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if converttime("23:45", "00:30") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if converttime("14:20", "15:25") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

