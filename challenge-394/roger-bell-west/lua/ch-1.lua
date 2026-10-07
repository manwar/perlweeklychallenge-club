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

function deepcopy(src)
   local dst = {}
   for k, v in pairs(src) do
      if type(v) == "table" then
         v = deepcopy(v)
      end
      dst[k] = v
   end
   return dst
end

function alternatecase(a)
   local uppers = map(split(a),
                      function (t)
                         return t == string.upper(t)
                      end
   )
   local queue = {}
   table.insert(queue, {uppers, 0})
   while #queue > 0 do
      local upct = table.remove(queue, 1)
      local up = upct[1]
      local ct = upct[2]
      local swaps = {}
      for i = 1,#up - 1 do
         if up[i] == up[i + 1] then
            if i > 1 then
               table.insert(swaps, i - 1)
            end
            if i < #up - 1 then
               table.insert(swaps, i + 1)
            end
         end
      end
      if #swaps == 0 then
         return ct
      end
      for _, sw in ipairs(swaps) do
         local uq = deepcopy(up)
         local tmp = uq[sw]
         uq[sw] = uq[sw + 1]
         uq[sw + 1] = tmp
         table.insert(queue, {uq, ct + 1})
      end
   end
   return 0
end

if alternatecase("aAbB") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alternatecase("AAbb") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alternatecase("AAAbbb") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alternatecase("aABb") == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if alternatecase("bBBAaa") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

