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

function toset(a)
   local cc = {}
   for _, c in ipairs(a) do
      cc[c] = true
   end
   return cc
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

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

function lsub(wm, t)
   local start = 1
   local state = 0
   local ll = {}
   for n = 1,#wm do
      if state == 0 then
         if wm[n] == t then
            start = n
            state = 1
         end
      else
         if wm[n] ~= t then
            table.insert(ll, n - start)
            state = 0
         end
      end
   end
   if state == 1 then
      table.insert(ll, 1 + #wm - start)
   end
   return math.max(table.unpack(ll))
end

function longestrepeatingcharacter(st, k)
   local origin = split(st)
   local targets = toset(origin)
   local longestsub = 0
   for t, _ in pairs(targets) do
      local queue = {}
      table.insert(queue, {origin, 0})
      while #queue > 0 do
         local x = table.remove(queue, 1)
         local wm = x[1]
         local ct = x[2]
         longestsub = math.max(longestsub, lsub(wm, t))
         if ct < k then
            local ctp = ct + 1
            for n = 1, #wm do
               if wm[n] ~= t then
                  local wmp = deepcopy(wm)
                  wmp[n] = t
                  table.insert(queue, {wmp, ctp})
               end
            end
         end
      end
   end
   return longestsub
end

if longestrepeatingcharacter("AAAAA", 2) == 5 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if longestrepeatingcharacter("ABCDE", 4) == 5 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if longestrepeatingcharacter("AAABBBBAA", 1) == 5 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if longestrepeatingcharacter("ABACADA", 2) == 5 then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if longestrepeatingcharacter("BAAABAAAA", 1) == 8 then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
