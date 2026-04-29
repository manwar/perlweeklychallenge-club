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

function map(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      table.insert(out, func(x))
   end
   return out
end

function filter(seq, func)
   local out = {}
   for _, x in ipairs(seq) do
      if func(x) then
         table.insert(out, x)
      end
   end
   return out
end

function windows(a, size, offset)
   local out = {}
   for i = 1, #a - size + 1, offset do
      local w = {}
      for j = 0, size - 1 do
         if i + j <= #a then
            table.insert(w, a[i + j])
         end
      end
      table.insert(out, w)
   end
   return out
end

function missingletter(a)
   local c = map(
      filter(
         split(a),
         function(i) return i ~= " " end
      ),
      function(i) return string.byte(i) end
   )
   local d = {}
   for _, i in ipairs(windows(c, 2, 1)) do
      if i[1] == 63 or i[2] == 63 then
         table.insert(d, 0)
      else
         table.insert(d, i[2] - i[1])
      end
   end
   for n, delta in ipairs(d) do
      if delta == 0 then
         local ch = 0
         if n < 3 then
            ch = c[n + 2] - d[n + 2]
         else
            ch = c[n] + d[n - 2]
         end
         return string.char(ch)
      end
   end
   return ""   
end

if missingletter("a c ? g i") == "e" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if missingletter("a d ? j m") == "g" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if missingletter("a e ? m q") == "i" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if missingletter("a c f ? k") == "h" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if missingletter("b e g ? l") == "j" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

