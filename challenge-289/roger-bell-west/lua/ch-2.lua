#! /usr/bin/lua

function shuffle(input)
   local ix = {}
   local keys = {}
   for n = 1, #input do
      table.insert(ix, n)
      table.insert(keys, math.random())
   end
   table.sort(ix, function (i, j) return keys[i] < keys[j] end)
   local out = {}
   for _, v in ipairs(ix) do
      table.insert(out, input[v])
   end
   return out
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

function join(t)
   local out=""
   for i, v in ipairs(t) do
      out = out .. v
   end
   return out
end

function jumble(st)
   return join(shuffle(split(st)))
end

math.randomseed(os.time())
while true do
   local line = io.read()
   if line == nil then break end
   local x = line
   local l = string.gsub(line, "(%a)(%a%a+)(%a)", function(a, b, c)
                            return a .. jumble(b) .. c
   end)
   print(l)
end
