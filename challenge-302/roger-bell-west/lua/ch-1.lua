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

function onesandzeroes(a, zeroes, ones)
   local ax = {}
   for _, ns in ipairs(a) do
      local o = 0
      local n = 0
      for __, c in ipairs(split(ns)) do
         if c == "0" then
            o = o + 1
         end
         if c == "1" then
            n = n + 1
         end
      end
      table.insert(ax, {o, n});
   end
   local mx = 0
   for mask = 1, (1 << #a) - 1 do
      local o = 0
      local n = 0
      local ct = 0
      for i, x in ipairs(ax) do
         if (mask & (1 << (i - 1))) > 0 then
            o = o + x[1]
            n = n + x[2]
            ct = ct + 1
            if o > zeroes or n > ones then
               break
            end
         end
      end
      if o <= zeroes and n <= ones then
         mx = math.max(mx, ct)
      end
   end
   return mx
end

if onesandzeroes({"10", "0001", "111001", "1", "0"}, 5, 3) == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if onesandzeroes({"10", "1", "0"}, 1, 1) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

