#! /usr/bin/lua

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
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

function propersize(t)
   local l=0
   for k,v in pairs(t) do
      l = l + 1
   end
   return l
end

function word2map(word)
   local m = {}
   for c in string.gmatch(string.lower(word), "%a") do
      if m[c] == nil then
         m[c] = 1
      else
         m[c] = m[c] + 1
      end
   end
   return m
end

function wordstickers(stickers, word)
   local w = word2map(word)
   local t = deepcopy(w)
   local stick = {}
   for _, s in ipairs(stickers) do
      local f = word2map(s)
      for _, c in ipairs(keys(f)) do
         t[c] = nil
      end
      table.insert(stick, f)
   end
   if propersize(t) > 0 then
      return 0
   end
   local stack = { {w, 0} }
   while #stack > 0 do
      local st = table.remove(stack, 1)
      if propersize(st[1]) == 0 then
         return st[2]
      else
         local n = st[2] + 1
         for _a, sti in ipairs(stick) do
            local sp = deepcopy(st[1])
            local v = false
            for _b, l in ipairs(keys(sti)) do
               if sp[l] ~= nil then
                  v = true
                  p = sp[l] - sti[l]
                  if p > 0 then
                     sp[l] = p
                  else
                     sp[l] = nil
                  end
               end
            end
            if v then
               table.insert(stack, {sp, n})
            end
         end
      end
   end
end

if wordstickers({"perl", "raku", "python"}, "peon") == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordstickers({"love", "hate", "angry"}, "goat") == 3 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordstickers({"come", "nation", "delta"}, "accomodation") == 4 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if wordstickers({"come", "country", "delta"}, "accomodation") == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

