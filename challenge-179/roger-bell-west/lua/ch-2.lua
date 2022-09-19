#! /usr/bin/lua

function sparkline(nn)
   local bar = {}
   for c = 0x2581, 0x2588 do
      table.insert(bar, utf8.char(c))
   end
   local mn = math.min(table.unpack(nn))
   local mx = math.max(table.unpack(nn))
   local inscale = mx - mn
   local outscale = #bar
   local out = ""
   for k,v in pairs(nn) do
      va = 1 + math.floor((v - mn) / inscale * outscale)
      if va > outscale then
         va = outscale
      end
      out = out .. bar[va]
   end
   return out
end

if sparkline({0, 10}) == "▁█" then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if sparkline({1, 2, 3, 4, 5, 6, 7, 8}) == "▁▂▃▄▅▆▇█" then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
