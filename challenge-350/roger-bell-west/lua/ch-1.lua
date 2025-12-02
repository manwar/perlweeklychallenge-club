#! /usr/bin/lua

function counterify(a)
   local cc = {}
   for _, c in ipairs(a) do
      if cc[c] == nil then
         cc[c] = 0
      end
      cc[c] = cc[c] + 1
   end
   return cc
end

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

function windows(a, n)
   local out = {}
   for i = 1, #a - n + 1 do
      local w = {}
      for j = 0, 2 do
         table.insert(w, a[i + j])
      end
      table.insert(out, w)
   end
   return out
end

function goodsubstrings(a)
   local p = 0
   for _, s in ipairs(windows(split(a), 3)) do
      local c = counterify(s)
      local mx = 0
      for __, v in pairs(c) do
         mx = math.max(mx, v)
      end
      if mx == 1 then
         p = p + 1
      end
   end
   return p
end

if goodsubstrings("abcaefg") == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodsubstrings("xyzzabc") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodsubstrings("aababc") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodsubstrings("qwerty") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if goodsubstrings("zzzaaa") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

